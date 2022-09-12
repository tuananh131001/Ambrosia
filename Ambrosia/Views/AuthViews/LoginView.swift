//
//  LoginView.swift
//  Ambrosia
//
//  Created by Khanh Tran Nguyen Ha on 10/09/2022.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userModel: UserModel

    @State var email = ""
    @State var password = ""

    @State var loginSuccess = false

    var body: some View {
        VStack {
            Spacer()

            // Sign up fields to sign up for a new account
            Group {
                TextField("Email", text: $email)
                    .padding()
                    .background(.thinMaterial)
                    .cornerRadius(10)
                    .textInputAutocapitalization(.never)
                SecureField("Password", text: $password)
                    .padding()
                    .background(.thinMaterial)
                    .cornerRadius(10)
            }

            // Sign up button
            Button(action: {
                login()
            }) {
                Text("Login")
                    .bold()
                    .frame(width: 360, height: 50)
                    .background(.thinMaterial)
                    .cornerRadius(10)
            }

            // Sign up message after pressing the sign up button
            if loginSuccess {
                Text("Login successfully! ✅")
                    .foregroundColor(.green)
            } else {
                Text("Invalid login credentails! ❌")
                    .foregroundColor(.red)
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
    func login() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
                loginSuccess = false
            } else {
                print(authResult?.additionalUserInfo?.isNewUser ?? "error")
                if((authResult?.additionalUserInfo?.isNewUser) != nil) {
                    userModel.isNewUser = true
                } else {
                    loginSuccess = true
                    dismiss()
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
