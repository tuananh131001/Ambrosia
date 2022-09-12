//
//  AuthenticationViewModel.swift
//  Ambrosia
//
//  Created by Khanh Tran Nguyen Ha on 12/09/2022.
//

import Firebase
import GoogleSignIn

class AuthenticationModel: ObservableObject {

    enum SignInState {
        case signedIn
        case signedOut
    }
    
    enum SignInMethod {
        case normal
        case google
        case phone
    }

    @Published var state: SignInState = .signedOut
    @Published var loginMethod: SignInMethod = .normal
    @Published var loginSuccess : Bool = false
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
    
    
    func GoogleSignIn() {
      // 1
      if GIDSignIn.sharedInstance.hasPreviousSignIn() {
        GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
            GGAuthenticateUser(for: user, with: error)
        }
      } else {
        // 2
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // 3
        let configuration = GIDConfiguration(clientID: clientID)
        
        // 4
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
        
        // 5
        GIDSignIn.sharedInstance.signIn(with: configuration, presenting: rootViewController) { [unowned self] user, error in
          GGAuthenticateUser(for: user, with: error)
        }
      }
    }
    
    private func GGAuthenticateUser(for user: GIDGoogleUser?, with error: Error?) {
      // 1
      if let error = error {
          loginSuccess = false
          print(error.localizedDescription)
          return
      }
      
      // 2
      guard let authentication = user?.authentication, let idToken = authentication.idToken else {
          loginSuccess = false
          return
      }
      
      let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
      
      // 3
      Auth.auth().signIn(with: credential) { [unowned self] (_, error) in
        if let error = error {
            loginSuccess = false
            print(error.localizedDescription)
        } else {
            loginSuccess = true
            loginMethod = .google
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
