//
//  AuthenticationViewModel.swift
//  Ambrosia
//
//  Created by Khanh Tran Nguyen Ha on 12/09/2022.
//

import Firebase
import GoogleSignIn

class AuthenticationModel: ObservableObject {

    // 1
    enum SignInState {
        case signedIn
        case signedOut
    }

    // 2
    @Published var state: SignInState = .signedOut
    @Published var loginSuccess: Bool = false
    @Published var isNewUser: Bool = false

    @Published var user: User = User(id: "", name: "", dob: Date(), selectedGender: 0)
    let genders = ["Male", "Female"]

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
                self.state = .signedIn
            }
        }
    }

    func GGSignOut() {
        // 1
        GIDSignIn.sharedInstance.signOut()

        do {
            // 2
            try Auth.auth().signOut()
            loginSuccess = false
            state = .signedOut
        } catch {
            print(error.localizedDescription)
        }
    }
}
