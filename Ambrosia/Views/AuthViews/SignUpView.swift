//
//  SignUpView.swift
//  UserLoginWithFirebase
//
//  Created by Tom Huynh on 9/3/22.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var email = ""
    @State var password = ""
    @State var passwordConfirmation = ""
    
    @State private var showSignUpMessage = false
    @State private var signUpMessage = ""
    @State var signUpSuccess = false
    
    @FocusState private var emailIsFocused : Bool
    @FocusState private var passwordIsFocused : Bool
    @FocusState private var confirmPasswordIsFocused : Bool
    
    var body: some View {
        VStack (spacing: 20){
            Spacer()
            
            // Sign up fields to sign up for a new account
            Group {
                TextField("Email", text: $email)
                    .modifier(TextFieldModifier())
                    .focused($emailIsFocused)
                    .border(Color.green, width: emailIsFocused ? 1 : 0)
                SecureField("Password", text: $password)
                    .modifier(TextFieldModifier())
                    .focused($passwordIsFocused)
                    .border(Color.green, width: passwordIsFocused ? 1 : 0)
                SecureField("Confirm Password", text: $passwordConfirmation)
                    .modifier(TextFieldModifier())
                    .focused($confirmPasswordIsFocused)
                    .border(passwordConfirmation != password ? Color.red : Color.green, width: (passwordConfirmation != password || confirmPasswordIsFocused) ? 1 : 0)
            }

            // Sign up button
            Button(action: {
                signUpSuccess = false
                if (email == "" || password == "" || passwordConfirmation == "") {
                    signUpMessage = "Please fill in all the fields"
                }
                else if (passwordConfirmation != password) {
                    signUpMessage = "Confirm password not match"
                }
                else {
                    signUp()
                }
                showSignUpMessage = true
            }) {
                Text("Sign Up")
                    .bold()
//                    .frame(width: 360, height: 50)
//                    .background(.thinMaterial)
//                    .cornerRadius(10)
            }
            .buttonStyle(ButtonStyle1())
            
            
            // Sign up message after pressing the sign up button
            if (showSignUpMessage) {
                if (signUpSuccess) {
                    Text("Sign Up Successfully! ✅")
                        .foregroundColor(.green)
                } else {
                    Text(signUpMessage)
                        .foregroundColor(.red)
                }
            }
            
            Spacer()
            
            // Button to dismiss the sign up sheet and go back to the sign in page
            Button {
                dismiss()
            } label: {
                Text("Back to Sign In Page")
            }

            Spacer()
        }
        
    }

    // Sign up function to use Firebase to create a new user account in Firebase
    func signUp() {        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
                signUpMessage = error?.localizedDescription ?? "Sign up unsuccessfully"
                signUpSuccess = false
            } else {
                signUpSuccess = true
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
