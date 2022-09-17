//
//  LoginPhoneModal.swift
//  Ambrosia
//
//  Created by Khanh Tran Nguyen Ha on 12/09/2022.
//

import SwiftUI
import Firebase

struct LoginPhoneModal: View {
    @EnvironmentObject var userModel: UserModel
    @EnvironmentObject var model: RestaurantModel
    
    @Binding var showLoginPhoneModal: Bool
    @State var checkCode: Bool = false
    @State var message: String = ""
    @State var phone: String = ""
    @State var code: String = ""
    
    
    var body: some View {
        ZStack {
            Color("Shadow")
                .edgesIgnoringSafeArea(.all)
            VStack {
                
                if (!checkCode) {
                    TextField("Enter phone number", text: $phone)
                        .modifier(TextFieldModifier())
                    
                    Button {
                        if (phone != "") {
                            sendCode()
                            message = ""
                            checkCode = true
                        }
                        else {
                            message = "Please enter phone number"
                        }
                    } label: {
                        Text("Send code via SMS")
                            .bold()
                    }
                    .buttonStyle(ButtonStyleWhite())
                    
                    if (message != "") {
                        Text(message)
                    }
                    
                }
                
                if (checkCode) {
                    SecureField("Enter code", text: $code)
                        .modifier(TextFieldModifier())
                    
                    
                    Button {
                        if (code != "") {
                            verifyPhoneLogin()
                            message = ""
                        }
                        else {
                            message = "Please enter code"
                        }
                    } label: {
                        Text("Verify")
                            .bold()
                    }
                    .buttonStyle(ButtonStyleWhite())
                    
                    if (message != "") {
                        Text(message)
                    }
                }

                
            }
            .padding(15)
            .frame(maxWidth: Constants.MODAL_WIDTH, minHeight: Constants.MODAL_MIN_HEIGHT)
            .background(Constants.PRIMARY_COLOR)
            .foregroundColor(.white)
            .cornerRadius(Constants.CONRNER_RADIUS)
            .overlay(
              Button(action: {
                  showLoginPhoneModal = false
                  checkCode = false
                  code = ""
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
    
    func sendCode() {
        print(phone)
        PhoneAuthProvider.provider()
          .verifyPhoneNumber(phone, uiDelegate: nil) { verificationID, error in
              
              if error != nil {
                  print("ERROR SEND CODE TO PHONE")
//                  print(error.localizedDescription)
                  return
              }
              print("Code Sent")
              UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
//              print("saved veri1: ", verificationID as Any)
          }
    }
    
    func verifyPhoneLogin() {
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
        print("veri2: ", verificationID as Any)
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID ?? "-1",
          verificationCode: code
        )
        
        Auth.auth().signIn(with: credential) { authResult, error in
            if error != nil {
                userModel.loginSuccess = false
//                print("signin err: ", error.localizedDescription)
                return
            }
        
            // User is signed in
            print("Sign in by PHONE is success")
            userModel.loginSuccess = true
            userModel.state = .signedIn
            model.requestGeolocationPermission()
        
        }
    }
    
}

