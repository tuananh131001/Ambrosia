/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 3
 Author: Tran Nguyen Ha Khanh
 ID: s3877707
 Created  date: 12/09/2022
 Last modified: 17/09/2022
 Acknowledgement:
 - Canvas
 */

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
            // MARK: - Blur background when open modal
            Color("Shadow")
                .edgesIgnoringSafeArea(.all)
            
            // MARK: - Content
            VStack {
                // Not check code yet
                if (!checkCode) {
                    // MARK: input phone num
                    TextField("Enter phone number", text: $phone)
                        .modifier(TextFieldModifier())
                    // MARK: senf using SMS
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
                    
                    // MARK: display message
                    if (message != "") {
                        Text(message)
                    }
                    
                }
                
                // Already check
                if (checkCode) {
                    // MARK: input code without seeing
                    SecureField("Enter code", text: $code)
                        .modifier(TextFieldModifier())
                    
                    // MARK: verify button
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
                    
                    // MARK: result message
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
                // MARK: close button
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
    
    // MARK: send code func
    func sendCode() {
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(phone, uiDelegate: nil) { verificationID, error in
                
                if error != nil {
                    return
                }
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
            }
    }
    
    // MARK: verify code func
    func verifyPhoneLogin() {
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID ?? "-1",
            verificationCode: code
        )
        
        Auth.auth().signIn(with: credential) { authResult, error in
            if error != nil {
                userModel.loginSuccess = false
                return
            }
            
            // User is signed in
            userModel.loginSuccess = true
            userModel.state = .signedIn
            model.requestGeolocationPermission()
            
        }
    }
    
}

