//
//  SignUpView.swift
//  UserLoginWithFirebase
//
//  Created by Tom Huynh on 9/3/22.
//

import SwiftUI
import Firebase
import FirebaseFirestore


struct SignUpView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userModel: UserModel
    @State var email = ""
    @State var password = ""
    @State var passwordConfirmation = ""
    @State var showMessage : Bool = false

    @FocusState private var emailIsFocused: Bool
    @FocusState private var passwordIsFocused: Bool
    @FocusState private var confirmPasswordIsFocused: Bool

    var body: some View {
        ZStack (alignment: .center) {
            VStack (spacing: 20) {

                VStack (spacing: 10) {
                    Group {
                        Text("AMBROSIA")
                            .font(Font(UIFont(name: "Chalkboard SE Bold", size: Constants.APP_NAME_LARGE_SIZE)! as CTFont))

                        Text("Join us for good meals !")
                            .font(Font(UIFont(name: "Chalkboard SE", size: Constants.APP_NAME_LARGE_SIZE - 20)! as CTFont))
                    }

                    // MARK: CAT GIF
                    GifView(name: "cat-eat") .frame(width: 130, height: 110)
                }
                .padding(.bottom, 10)


                VStack (spacing: 8) {

                    // Sign up fields to sign up for a new account
                    Group {
                        TextField("Email", text: $email)
                            .modifier(TextFieldModifier())
                            .focused($emailIsFocused)
                            .border(Color(uiColor: Constants.PRIMARY_COLOR_UI), width: emailIsFocused ? 1 : 0)
                        SecureField("Password", text: $password)
                            .modifier(TextFieldModifier())
                            .focused($passwordIsFocused)
                            .border(Color(uiColor: Constants.PRIMARY_COLOR_UI), width: passwordIsFocused ? 1 : 0)
                        SecureField("Confirm Password", text: $passwordConfirmation)
                            .modifier(TextFieldModifier())
                            .focused($confirmPasswordIsFocused)
                            .border(passwordConfirmation != password ? Color.red : Color(uiColor: Constants.PRIMARY_COLOR_UI), width: (passwordConfirmation != password || confirmPasswordIsFocused) ? 1 : 0)
                    }
                        .multilineTextAlignment(.leading)

                    // Sign up message after pressing the sign up button
                    if (showMessage) {
                        Text(userModel.firebaseService.signUpMessage)
                            .foregroundColor(userModel.firebaseService.signUpSuccess ? .green : .red)
                    }
                }

                VStack (spacing: 10) {
                    // Sign up button
                    Button(action: {
                        // add sound effect when click button
                        SoundModel.clickButtonSound()
                        
                        FirebaseService.services.signUp(email: email, password: password, passwordConfirmation: passwordConfirmation,user:userModel)
                        showMessage = true
                    }) {
                        Text("Sign Up")
                            .bold()
                    }
                        .buttonStyle(ButtonStylePrimary())


                    // Button to dismiss sign up sheet and go back to sign in page
                    Button {
                        SoundModel.clickOtherSound()
                        
                        dismiss()
                    } label: {
                        Text("Back to Sign In Page")
                    }
                }
            }
                .padding(.vertical, Constants.FORM_PADDING_VERTICAL)
                .padding(.horizontal, Constants.FORM_PADDING_HORIZAONTAL)
                .multilineTextAlignment(.center)
                .foregroundColor(Constants.PRIMARY_COLOR)

        }
            .background(.white)
            .frame(minWidth: Constants.FIELD_MIN_WIDTH, maxWidth: Constants.FIELD_MAX_WIDTH)
            .cornerRadius(Constants.CONRNER_RADIUS)

    }

}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
