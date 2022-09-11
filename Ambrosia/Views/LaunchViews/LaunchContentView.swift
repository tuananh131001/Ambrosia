/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Tran Mai Nhung
 ID: s3879954
 Created  date: 19/07/2022
 Last modified: 07/08/2022
 Acknowledgement:
 - Canvas, CodeWithChris Course
 */
import SwiftUI
import Firebase
struct LaunchContentView: View {
    @EnvironmentObject var model: RestaurantModel
    @State var email = ""
    @State var password = ""
    @State var phone = ""
    @State var code = ""
    @State var appleID = ""
    @State var appleIDPassword = ""
    @State private var showLoginMessage = false
    @State private var showingSignUpSheet = false
    @State private var showLoginPhoneModal = false
    @State private var showLoginAppleModal = false
    @State private var checkCode = false
    @State private var showEnterCodeField = false
    
    @State private var loginMessage = ""
    
    @FocusState private var emailIsFocused : Bool
    @FocusState private var passwordIsFocused : Bool
    
    var openSetting = false
    var body: some View {
        ZStack (alignment: .center) {
            Rectangle()
                .foregroundColor(Constants.PRIMARY_COLOR)
            
            
            // MARK: LOGIN PAGE CONTENT
            ZStack {
                ZStack {
                    // MARK: LOGIN INPUT FIELDS
                    VStack (spacing: 20) {
                        VStack (spacing: 10) {
                            Text("AMBROSIA")
                                .bold()
                                .font(Font(UIFont(name: "Chalkboard SE Bold", size: Constants.APP_NAME_LARGE_SIZE)! as CTFont))
                                .foregroundColor(Constants.PRIMARY_COLOR)
                            
                            // MARK: CAT GIF
                            GifView(name: "cat-eat")                            .frame(width: 130, height: 110)
                        }
                        
                        VStack (spacing: 10) {
                            Group {
                                TextField("Email", text: $email)
                                    .modifier(TextFieldModifier())
                                SecureField("Password", text: $password)
                                    .modifier(TextFieldModifier())
                            }
                            .multilineTextAlignment(.leading)

                            // MARK: LOGIN MESSAGE
                            // Login message after pressing the login button
                            if (showLoginMessage) {
                            Text(loginMessage)
                                .foregroundColor(model.loginSuccess ? .green : .red)
                            }
                        }
                        
                        VStack (spacing: 10) {
                            // MARK: LOGIN BUTTON
                            Button {
                                login()
                                showLoginMessage = true
                            } label: {
                                Text("Sign In")
                                    .bold()
                            }
                            .buttonStyle(ButtonStylePrimary())
                            
                            // MARK: REGISTER BUTTON
                            // Button to show the sign up sheet
                            Button {
                                showingSignUpSheet.toggle()
                            } label: {
                                Text("Sign Up Here!")
                            }
                            
                            Text("or")
                                .foregroundColor(.gray)
                            
                            // MARK: ALTERNATIVE LOGIN
                            Group {
                                // Button to login using phone
                                Button {
                                    showLoginPhoneModal = true
                                } label: {
                                    HStack {
                                        Image("phone-icon")
                                        Text("Sign in with Phone")
                                            .bold()
                                    }
                                }
                                
                                // Button to login using Apple
                                Button {
                                    showLoginAppleModal = true
                                } label: {
                                    HStack {
                                        Image("apple-logo")
                                        Text("Sign in with Apple ID")
                                            .bold()
                                    }
                                }
                            }
                            .buttonStyle(ButtonStyleLightPrimary())
                        }
                    

                    }
                    .padding(.vertical, Constants.FORM_PADDING_VERTICAL)
                    .padding(.horizontal, Constants.FORM_PADDING_HORIZAONTAL)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Constants.PRIMARY_COLOR)
                   
                }
                .background(.white)
                .frame(minWidth: Constants.FIELD_MIN_WIDTH, maxWidth: Constants.FIELD_MAX_WIDTH)
                .foregroundColor(.white)
                .cornerRadius(Constants.CONRNER_RADIUS)
                .shadow(color: Color("Shadow"), radius: 6.0, x: 2, y: 2)
                

//                // MARK: open setting button
//                Button {
//                    // open app setting
//                    if openSetting {
//                        // Open settings by getting the settings url
//                        if let url = URL(string: UIApplication.openSettingsURLString) {
//                            if UIApplication.shared.canOpenURL(url) {
//                                // If we can open this settings url, then open it
//                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
//                            }
//                        }
//                    }
//                    // ask user permission window (when not been ask before)
//                        else {
//                        model.requestGeolocationPermission()
//                    }
//
//                } label: {
//                    // display button to use app
//                    ZStack {
//                        Rectangle()
//                            .foregroundColor(.black)
//                            .frame(height: 50)
//                            .cornerRadius(15)
//                            .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.3), radius: 10, x: -5, y: 5)
//
//                        Text("Let's Eat")
//                            .bold()
//                            .foregroundColor(.white)
//                            .padding()
//                    }
//
//
//                }


            }
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            
            // MARK: MODAL PHONE LOGIN
            if (showLoginPhoneModal) {
                ZStack {
                    Color("Shadow")
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        TextField("Enter phone number", text: $email)
                            .modifier(TextFieldModifier())
                        
                        if (checkCode) {
                            TextField("Enter code", text: $code)
                                .modifier(TextFieldModifier())
                        }
                        
                        Button {
                            if (!checkCode) {
                                checkCode = true
                            }
                            else {
                                loginPhone()
                            }
                        } label: {
                            Text(!checkCode ? "Send code via SMS" : "Verify")
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
                          showLoginPhoneModal = false
                          checkCode = false
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
            
            // MARK: MODAL APPLE LOGIN
            if (showLoginAppleModal) {
                ZStack {
                    Color("Shadow")
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack (spacing: 10) {
                        TextField("Enter Apple ID", text: $appleID)
                            .modifier(TextFieldModifier())
                        
                        TextField("Enter password", text: $appleIDPassword)
                            .modifier(TextFieldModifier())
                        
                        
                        Button {
                            showLoginAppleModal = true
                            appleIDPassword = ""
                        } label: {
                            Text("Sign in")
                                .bold()
                        }
                        .buttonStyle(ButtonStyleWhite())
                    }
                    .padding()
                    .frame(maxWidth: Constants.MODAL_WIDTH, minHeight: Constants.MODAL_MIN_HEIGHT)
                    .background(Constants.PRIMARY_COLOR)
                    .foregroundColor(.white)
                    .cornerRadius(Constants.CONRNER_RADIUS)
                    .overlay(
                      Button(action: {
                          showLoginAppleModal = false
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
        }.sheet(isPresented: $showingSignUpSheet) {
            SignUpView()
        }
            .ignoresSafeArea(.all, edges: .all)

    }
    
    // MARK: LOGIN LOGIC
    // Login function to use Firebase to check username and password to sign in
    func login() {
        if (email == "" || password == "") {
            loginMessage = "Please enter email and password"
            model.loginSuccess = false
        }
        else {
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    let msg = error?.localizedDescription ?? ""
                    print(msg)
                    if (msg.contains("no user record")) {
                        loginMessage = "This email hasn't registered yet"
                    }
                    else {
                        loginMessage = "Invalid sign-in credentials"
                    }
                    model.loginSuccess = false
                } else {
                    print("success")
                    loginMessage = "Log in successfully"
                    model.loginSuccess = true
                    model.requestGeolocationPermission()
                }
            }
        }
    }
    
    func loginPhone() {
        PhoneAuthProvider.provider()
          .verifyPhoneNumber(phone, uiDelegate: nil) { verificationID, error in
              if let error = error {
                  print(error.localizedDescription)
//                self.showMessagePrompt(error.localizedDescription)
                return
              }
              // Sign in using the verificationID and the code sent to the user
              // ...
          }
    }
    
    func loginApple() {
        
    }

}
