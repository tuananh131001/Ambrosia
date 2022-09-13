//
//  ForgetPasswordModal.swift
//  Ambrosia
//
//  Created by Khanh Tran Nguyen Ha on 12/09/2022.
//

import SwiftUI
import Firebase

struct ForgetPasswordModal: View {
    @Binding var showForgetPasswordModal: Bool
    @State var email: String = ""
    @State var message: String = ""
    @State var showMessage: Bool = false
    
    var body: some View {
        ZStack {
            Color("Shadow")
                .edgesIgnoringSafeArea(.all)
            VStack {
                TextField("Enter email", text: $email)
                    .modifier(TextFieldModifier())
                
                Button {
                    if (email != "") {
                        resetPassword()
                    }
                    else {
                        message = "Please enter email"
                    }
                    showMessage = true
                    
                } label: {
                    Text("Send")
                        .bold()
                }
                .buttonStyle(ButtonStyleWhite())
                
                if (showMessage && message != "") {
                    Text(message)
                }
                
            }
            .padding(15)
            .frame(maxWidth: Constants.MODAL_WIDTH, minHeight: Constants.MODAL_MIN_HEIGHT)
            .background(Constants.PRIMARY_COLOR)
            .foregroundColor(.white)
            .cornerRadius(Constants.CONRNER_RADIUS)
            .overlay(
              Button(action: {
                  showForgetPasswordModal = false
              }) {
                Image(systemName: "xmark.circle")
                  .font(.title)
              }
                .foregroundColor(.white)
                .padding(.top, 20)
                .padding(.trailing, 20),
                alignment: .topTrailing
                )
        }
    }
    
    func resetPassword() {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let error = error {
                message = "Cannot send message to your email"
                //show alert here
                print(error.localizedDescription)
            }
            else {
                //show alert here
                message = "We sent you an email with instructions on how to reset your password"
                print("We send you an email with instructions on how to reset your password.")
            }
        }
    }
}
