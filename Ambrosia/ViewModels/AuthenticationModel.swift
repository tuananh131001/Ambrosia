//
//  AuthenticationViewModel.swift
//  Ambrosia
//
//  Created by Khanh Tran Nguyen Ha on 12/09/2022.
//

import Firebase
import GoogleSignIn


var provider: OAuthProvider?
var authMicrosoft: Auth?

class AuthenticationModel: ObservableObject {

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

    @Published var user: User = User(id: "", name: "", dob: Date(), selectedGender: 0)
    let genders = ["Male", "Female"]

    @Published var loginMethod: SignInMethod = .normal
    @Published var loginMessage = ""
    
//    func NormalSignIn(email: String, password: String) {
//        if (email == "" || password == "") {
//            self.loginMessage = "Please enter email and password"
//            self.loginSuccess = false
//        }
//        else {
//            Auth.auth().signIn(withEmail: email, password: password){ (result, error) in
//                if error != nil {
//                    let err = error?.localizedDescription ?? ""
//                    print(err)
//                    if (err.contains("no user record")) {
//                        self.loginMessage = "This email hasn't register yet"
//                    }
//                    else {
//                        self.loginMessage = "Invalid sign-in credentials"
//                    }
//                    self.loginSuccess = false
//                } else {
//                    print("success")
//                    self.loginMessage = "successfully"
//                    self.loginSuccess = true
//                }
//            }
//        }
//    }
    func MicrosoftSignIn() {
        provider = OAuthProvider(providerID: "microsoft.com")
        provider?.customParameters = [
          "prompt": "consent",
          "login_hint": ""
        ]
         
//        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
//        guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
        
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
    
//    func GGSignOut() {
//      GIDSignIn.sharedInstance.signOut()
//      
//      do {
//            try Auth.auth().signOut()
//            loginSuccess = false
//            state = .signedOut
//      } catch {
//        print(error.localizedDescription)
//      }
//    }
//    
//    func NormalSignOut() {
//        let firebaseAuth = Auth.auth()
//        do {
//            try firebaseAuth.signOut()
//            loginSuccess = false
//            state = .signedOut
//        } catch let signOutError as NSError {
//            print("Error signing out: %@", signOutError)
//        }
//    }
    
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
