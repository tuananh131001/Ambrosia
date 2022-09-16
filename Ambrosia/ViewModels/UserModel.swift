//
//  UserModel.swift
//  Ambrosia
//
//  Created by William on 14/09/2022.
//

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
    case phone
    case microsoft
}

class UserModel: ObservableObject {
    @Published var user: User = User(id: "", name: "", dob: Date(), selectedGender: 0, email: "")
    let genders = ["Male", "Female"]
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

    // Favorite
    func isRestaurantFavorite(restaurant: Restaurant) -> Int? {
            return user.favouriteRestaurants.firstIndex { $0.placeId ==  restaurant.placeId}
    }

    //Fetch User
    func fetchUserInfo(id:String,userModel:UserModel,restaurantModel: RestaurantModel){
        firebaseService.getUserFirebase(id: id,userModel: userModel,restaurantModel: restaurantModel)
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


    func autoLoginNormal(restaurantModel: RestaurantModel) {
        let userDefaults = UserDefaults.standard
        if userDefaults.string(forKey: "email") != nil {
            let email = userDefaults.string(forKey: "email") ?? ""
            let password = userDefaults.string(forKey: "password") ?? ""
            self.NormalSignIn(email: email, password: password, restaurantModel: restaurantModel)
        }
    }

    func autoLoginMicrosoft(restaurantModel: RestaurantModel) {
        let userDefaults = UserDefaults.standard
        if userDefaults.string(forKey: "email") != nil {
            let email = userDefaults.string(forKey: "email") ?? ""
            let password = userDefaults.string(forKey: "password") ?? ""
            self.NormalSignIn(email: email, password: password, restaurantModel: restaurantModel)
        }
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
                    print("NORMAL LOGIN ERROR: ", err)
                    if (err.contains("no user record")) {
                        self.loginMessage = "This email hasn't register yet"
                    }
                    else {
                        self.loginMessage = "Invalid sign-in credentials"
                    }
                    self.loginSuccess = false
                } else {
                    UserDefaults.standard.setValue("normal", forKey: "loginType")
                    self.fetchUserInfo(id: result?.user.uid ?? "", userModel: self, restaurantModel: restaurantModel)
//                    self.firebaseService.getUserFirebase(id: result?.user.uid ?? "Bug Normal Login",userModel: self,restaurantModel: restaurantModel)
                    self.userId = result?.user.uid ?? ""
                    self.loginMessage = "Login successfully. Redirecting..."
                    self.loginMethod = .normal
                    self.loginSuccess = true
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

        provider?.scopes = ["mail.read"]

        provider?.getCredentialWith(nil) { credential, error in
            if error != nil {
                print(error?.localizedDescription ?? "FAILED GET CREDENTIAL MICROSOFT")
            }

            if let x = credential {
                Auth.auth().signIn(with: x) { result, error in
                    if error != nil {
                        self.loginSuccess = false
                        print(error?.localizedDescription ?? "FAILED LOGIN MICROSOFT")
                    }
                    else {
                        UserDefaults.standard.setValue("microsoft", forKey: "loginType")
                        self.fetchUserInfo(id: Auth.auth().currentUser?.uid ?? "error",userModel: self, restaurantModel: restaurantModel)
                        self.loginMessage = "Login successfully. Redirecting..."
                        self.loginMethod = .microsoft
                        self.loginSuccess = true
                    }

                }
            } else {
                print("FAILED GET CREDENTAIL MICROSOFT")
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
        if let error = error {
            loginSuccess = false
            print(error.localizedDescription)
            return
        }

        guard let authentication = user?.authentication, let idToken = authentication.idToken else {
            loginSuccess = false
            return
        }

        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)

        Auth.auth().signIn(with: credential) { [unowned self] (_, error) in
            if let error = error {
                loginSuccess = false
                print(error.localizedDescription)
            } else {
                UserDefaults.standard.setValue("google", forKey: "loginType")
                self.fetchUserInfo(id: Auth.auth().currentUser?.uid ?? "error", userModel: self, restaurantModel: restaurantModel)
                loginMethod = .google
                self.loginMessage = "Login successfully. Redirecting..."
                loginSuccess = true
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
        } catch {
            print(error.localizedDescription)
        }
    }
}
