/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 3
    Author: Nguyen Tuan Anh, Vo Quoc Huy, Tran Nguyen Ha Khanh, Tran Mai Nhung
    ID: s3864077, s3823236, s3877707, s3879954
    Created  date: 14/09/2022
    Last modified: 17/09/2022
    Acknowledgement:
    - Canvas
*/

import Foundation
import Firebase
import FirebaseFirestoreSwift
import GoogleSignIn
import FirebaseMLModelDownloader

var provider: OAuthProvider?
var authMicrosoft: Auth?

enum SignInMethod {
    case normal
    case google
    case microsoft
}

class UserModel: ObservableObject {
    @Published var user: User = User(id: "", name: "", dob: Date(), selectedGender: 0, email: "", avatarStr: "")
    let genders = ["Male", "Female", "Other"]
    @Published var firebaseService = FirebaseService.services

    enum SignInState {
        case signedIn
        case signedOut
    }

    @Published var state: SignInState = .signedOut
    @Published var loginSuccess: Bool = false
    @Published var isNewUser: Bool = false
    @Published var loginMethod: SignInMethod = .normal
    @Published var loginMessage = ""
    @Published var userId: String = ""

    // MARK: Favorite
    func isRestaurantFavorite(restaurant: Restaurant) -> Int? {
        return user.favouriteRestaurants.firstIndex { $0.placeId == restaurant.placeId }
    }

    // MARK: is dark mode on
    func updateUserThemeMode() {
        firebaseService.updateThemeMode(user: self.user)
    }

    // MARK: Fetch User
    func fetchUserInfo(id: String, userModel: UserModel, restaurantModel: RestaurantModel) {
        firebaseService.getUserFirebase(id: id, userModel: userModel, restaurantModel: restaurantModel)
        if (self.user.email == "") {
            if let usertemp = Auth.auth().currentUser {
                if (usertemp.email != "") {
                    self.user.email = usertemp.email ?? "email is hidden"
                }
                else if (usertemp.providerData[0].email != "") {
                    self.user.email = usertemp.providerData[0].email ?? "email is hidden"
                }
            }
        }
    }

    func saveCurrentLoginNormal(email: String, password: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(email, forKey: "email")
        userDefaults.setValue(password, forKey: "password")
        userDefaults.setValue(Auth.auth().currentUser?.uid ?? "error", forKey: "uid")
    }

    func saveCurrentLoginMicrosoft(credential: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(Auth.auth().currentUser?.uid ?? "error", forKey: "uid")
    }


    func autoLogin(restaurantModel: RestaurantModel, loginType: String) {
        if (loginType == "normal") {
            let userDefaults = UserDefaults.standard
            let email = userDefaults.string(forKey: "email") ?? ""
            let password = userDefaults.string(forKey: "password") ?? ""
            self.NormalSignIn(email: email, password: password, restaurantModel: restaurantModel)
        }
        else if (loginType == "google") {
            self.GoogleSignIn(restaurantModel: restaurantModel)
        }
    }

//    func autoLoginMicrosoft(restaurantModel: RestaurantModel) {
//        let userDefaults = UserDefaults.standard
//        if userDefaults.string(forKey: "email") != nil {
//            let email = userDefaults.string(forKey: "email") ?? ""
//            let password = userDefaults.string(forKey: "password") ?? ""
//            self.NormalSignIn(email: email, password: password, restaurantModel: restaurantModel)
//        }
//    }


    func resetDefaultAfterLogin(loginMethod: SignInMethod) {
        UserDefaults.standard.setValue("", forKey: "email")
        UserDefaults.standard.setValue("", forKey: "password")
        UserDefaults.standard.setValue(Auth.auth().currentUser?.uid ?? "uid error", forKey: "uid")
        self.loginMessage = "Login successfully. Redirecting..."
        self.loginMethod = loginMethod
        self.loginSuccess = true
    }


    func removeCurrentLogin() {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue("", forKey: "loginType")
        userDefaults.setValue("", forKey: "email")
        userDefaults.setValue("", forKey: "password")
        userDefaults.setValue("", forKey: "uid")
    }


    func NormalSignIn(email: String, password: String, restaurantModel: RestaurantModel) {
        if (email == "" || password == "") {
            self.loginMessage = "Please enter email and password"
            self.loginSuccess = false
        }
        else {
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    let err = error?.localizedDescription ?? ""
                    if (err.contains("no user record")) {
                        self.loginMessage = "This email hasn't registered yet"
                    }
                    else {
                        self.loginMessage = "Invalid sign-in credentials"
                    }
                    self.loginSuccess = false
                } else {
                    self.resetDefaultAfterLogin(loginMethod: .normal)
                    UserDefaults.standard.setValue("normal", forKey: "loginType")
                    self.saveCurrentLoginNormal(email: email, password: password)
                }
            }
        }
    }

    func MicrosoftSignIn(restaurantModel: RestaurantModel) {
        provider = OAuthProvider(providerID: "microsoft.com")
        provider?.customParameters = [
            "prompt": "consent",
            "login_hint": ""
        ]

        provider?.getCredentialWith(nil) { credential, error in
            if error != nil {
            }

            if let x = credential {
                Auth.auth().signIn(with: x) { result, error in
                    if error != nil {
                        self.loginSuccess = false
                    }
                    else {
                        self.resetDefaultAfterLogin(loginMethod: .microsoft)
                        UserDefaults.standard.setValue("microsoft", forKey: "loginType")

                    }

                }
            } else {
            }
        }

    }


    func GoogleSignIn(restaurantModel: RestaurantModel) {
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
                GGAuthenticateUser(for: user, with: error, restaurantModel: restaurantModel)
            }
        } else {
            guard let clientID = FirebaseApp.app()?.options.clientID else { return }

            let configuration = GIDConfiguration(clientID: clientID)

            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            guard let rootViewController = windowScene.windows.first?.rootViewController else { return }

            GIDSignIn.sharedInstance.signIn(with: configuration, presenting: rootViewController) { [unowned self] user, error in
                GGAuthenticateUser(for: user, with: error, restaurantModel: restaurantModel)
            }
        }
    }

    private func GGAuthenticateUser(for user: GIDGoogleUser?, with error: Error?, restaurantModel: RestaurantModel) {
        if error != nil {
            loginSuccess = false
            return
        }

        guard let authentication = user?.authentication, let idToken = authentication.idToken else {
            loginSuccess = false
            return
        }

        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)

        Auth.auth().signIn(with: credential) { [unowned self] (_, error) in
            if error != nil {
                loginSuccess = false
            } else {
                resetDefaultAfterLogin(loginMethod: .google)
                UserDefaults.standard.setValue("google", forKey: "loginType")
            }
        }
    }



    func SignOut() {
        if (loginMethod == .google) {
            GIDSignIn.sharedInstance.signOut()
        }
        do {
            try Auth.auth().signOut()
            removeCurrentLogin()
            loginSuccess = false
            state = .signedOut
            loginMessage = ""
        } catch {
        }
    }
}
