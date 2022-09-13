//
//  FirebaseService.swift
//  Ambrosia
//
//  Created by William on 12/09/2022.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import GoogleSignIn


var provider: OAuthProvider?
var authMicrosoft: Auth?


class FirebaseService: ObservableObject {
    static let services = FirebaseService()
    
    @Published var showSignUpMessage = false
    @Published var signUpMessage = ""
    @Published var signUpSuccess = false
    
    @Published var user: User = User(id: "", name: "", dob: Date(), selectedGender: 0)
    let genders = ["Male", "Female"]
    
    
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


    
    
    // Sign up function to use Firebase to create a new user account in Firebase
    func signUp(email: String, password: String, passwordConfirmation: String, user:FirebaseService)  {
        if (email == "" || password == "" || passwordConfirmation == "") {
            self.signUpMessage = "Please fill in all the fields"
        }
        else if (passwordConfirmation != password) {
            self.signUpMessage = "Confirm password doesn't match"
        }
        else {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if error != nil {
                    let msg = error?.localizedDescription ?? ""
                    if (msg.contains("email address is badly formatted")) {
                        self.signUpMessage = "Invalid email address"
                    }
                    else if (msg.contains("email address is already in use")) {
                        self.signUpMessage = "This email address is already in use"
                    }
                    else {
                        self.signUpMessage = "Sign up unsuccessfully"
                    }
                } else {
                    self.signUpMessage = "Sign up successfully"
                    guard let userID = authResult?.user.uid else { return }
                    Firestore.firestore().collection("user").document(userID).setData([
                        "name": "Sir",
                        "email": authResult?.user.email ?? ""
                        ]) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                        }
                    }
                    user.loginSuccess = true
                    user.isNewUser = true
                    self.signUpSuccess = true
                    
                }
            }
        }
    }
    
    func updateUser(user:User ) {
        Firestore.firestore().collection("user").document(user.id).setData(["name": user.name, "dob": user.dob, "gender": user.selectedGender], merge: true)
    }

    
    
    
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
