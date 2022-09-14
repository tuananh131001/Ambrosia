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
class UserModel: ObservableObject {
    @Published var user: User = User(id: "", name: "", dob: Date(), selectedGender: 0, email: "")
    let genders = ["Male", "Female"]
    @Published var firebaseService = FirebaseService.services
    
    enum SignInState {
        case signedIn
        case signedOut
    }
    
    enum SignInMethod {
        case normal
        case google
        case phone
        case microsoft
    }

    @Published var state: SignInState = .signedOut
    @Published var loginSuccess: Bool = false
    @Published var isNewUser: Bool = false
    @Published var loginMethod: SignInMethod = .normal
    @Published var loginMessage = ""
    
    // Favorite
    func isRestaurantFavorite(restaurant: Restaurant) -> Int? {
            return user.favouriteRestaurants.firstIndex { $0.place_id ==  restaurant.place_id}
    }
    
    //Fetch User
    func fetchUserInfo(id:String,userModel:UserModel,restaurantModel: RestaurantModel){
        firebaseService.getUserFirebase(id: id,userModel: userModel,restaurantModel: restaurantModel)
    }
    
    func MicrosoftSignIn() {
        provider = OAuthProvider(providerID: "microsoft.com")
        provider?.customParameters = [
            "prompt": "consent",
            "login_hint": ""
        ]

        provider?.getCredentialWith(nil) { credential, error in
            if error != nil {
                print(error?.localizedDescription ?? "FAILED GET CREDENTAIL MICROSOFT")
            }


            if let x = credential {
                Auth.auth().signIn(with: x) { authResult, error in
                    if error != nil {
                        self.loginSuccess = false
                        print(error?.localizedDescription ?? "FAILED LOGIN MICROSOFT")
                    }
                    else {
                        print("login success")
                        self.loginSuccess = true
                        self.loginMessage = "Login successfully. Redirecting..."
                        self.loginMethod = .microsoft
                        self.state = .signedIn
                    }

                }
            } else {
                print("FAILED GET CREDENTAIL MICROSOFT")
            }
        }

    }

    func GoogleSignIn() {
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
                GGAuthenticateUser(for: user, with: error)
            }
        } else {
            guard let clientID = FirebaseApp.app()?.options.clientID else { return }

            let configuration = GIDConfiguration(clientID: clientID)

            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            guard let rootViewController = windowScene.windows.first?.rootViewController else { return }

            GIDSignIn.sharedInstance.signIn(with: configuration, presenting: rootViewController) { [unowned self] user, error in
                GGAuthenticateUser(for: user, with: error)
            }
        }
    }

    private func GGAuthenticateUser(for user: GIDGoogleUser?, with error: Error?) {
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
                loginSuccess = true
                loginMethod = .google
                self.loginMessage = "Login successfully. Redirecting..."
                self.state = .signedIn
            }
        }
    }


    func SignOut() {
        if (loginMethod == .google) {
            GIDSignIn.sharedInstance.signOut()
        }
        do {

            try Auth.auth().signOut()
            loginSuccess = false
            state = .signedOut
        } catch {
            print(error.localizedDescription)
        }
    }
}
