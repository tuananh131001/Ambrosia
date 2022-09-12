//
//  FirebaseService.swift
//  Ambrosia
//
//  Created by William on 12/09/2022.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
class FirebaseService: ObservableObject {
    static let services = FirebaseService()
    @Published var showSignUpMessage = false
    @Published var signUpMessage = ""
    @Published var signUpSuccess = false
    // Sign up function to use Firebase to create a new user account in Firebase
    func signUp(email: String, password: String, passwordConfirmation: String,user:UserModel)  {
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

}
