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
    
    var body: some View {
        ZStack {
            Color("Shadow")
                .edgesIgnoringSafeArea(.all)
            VStack {
                TextField("Enter email", text: $email)
                    .modifier(TextFieldModifier())
                
                Button {
                    
                } label: {
                    Text("Next")
                        .bold()
                }
                .buttonStyle(ButtonStyleWhite())
                

                
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
}
