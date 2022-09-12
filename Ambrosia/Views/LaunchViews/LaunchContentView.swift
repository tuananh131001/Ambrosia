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
    @EnvironmentObject var restaurantModel: RestaurantModel
    @EnvironmentObject var userModel: AuthenticationModel
    @EnvironmentObject var authModel: AuthenticationModel
    
    @State var email = ""
    @State var password = ""
    @State var phone = ""
    @State var code = ""
    @State var appleID = ""
    @State var appleIDPassword = ""
    @State var showLoginMessage = false
    @State var showingSignUpSheet = false
    @State var showLoginPhoneModal = false
    @State var showForgetPasswordModal = false
    @State var checkCode = false
    @State var showEnterCodeField = false
    
    @State private var loginMessage = ""

    @FocusState private var emailIsFocused: Bool
    @FocusState private var passwordIsFocused: Bool

    var openSetting = false
    var body: some View {
        ZStack (alignment: .center) {
            Rectangle()
                .foregroundColor(Constants.PRIMARY_COLOR)


            // MARK: LOGIN PAGE CONTENT
            ZStack (alignment: .center) {
                ZStack (alignment: .center) {
                    // MARK: LOGIN INPUT FIELDS
                    VStack (spacing: 20) {
                        VStack (spacing: 10) {
                            Text("AMBROSIA")
                                .bold()
                                .font(Font(UIFont(name: "Chalkboard SE Bold", size: Constants.APP_NAME_LARGE_SIZE)! as CTFont))
                                .foregroundColor(Constants.PRIMARY_COLOR)

                            // MARK: CAT GIF
                            GifView(name: "cat-eat")
                                .frame(width: 130, height: 110)
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
                                .foregroundColor(authModel.loginSuccess ? .green : .red)
                            }
                        }

                        VStack (spacing: 10) {
                            
                            // MARK: BTN FORGET
                            Button {
                                showForgetPasswordModal = true
                            } label: {
                                Text("Forget password?")
                            }
                            
                            // MARK: BTN LOGIN
                            Button {
                                login()
                                showLoginMessage = true
                            } label: {
                                Text("Sign In")
                                    .bold()
                            }
                            .buttonStyle(ButtonStylePrimary())
                            
                            // MARK: BTN PHONE
                            Button {
                                showLoginPhoneModal = true
                            } label: {
                                HStack {
                                    Image("phone-icon")
                                    Text("Sign in with Phone")
                                        .bold()
                                }
                            }
                            .buttonStyle(ButtonStylePrimary())
                            
                            // MARK: BTN GOOGLE
                            Button {
                                authModel.GoogleSignIn()
                            } label: {
                                HStack {
                                    Image("google-icon")
                                    Text("Sign in with Google")
                                        .bold()
                                }
                            }
                            .buttonStyle(ButtonStylePrimary())
                            
                            Text("or")
                                .foregroundColor(.gray)
                            
                            
                            // MARK: BTN REGISTER
                            // Button to show the sign up sheet
                            Button {
                                showingSignUpSheet.toggle()
                            } label: {
                                Text("Sign Up Here!")
                                    .bold()
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
                
            }
                .foregroundColor(.white)
                .multilineTextAlignment(.center)

            // MARK: MODAL PHONE LOGIN
            if (showLoginPhoneModal) {
                LoginPhoneModal(showLoginPhoneModal: $showLoginPhoneModal)
            }
            
            // MARK: MODAL FORGET PW
            if (showForgetPasswordModal) {
                ForgetPasswordModal(showForgetPasswordModal: $showForgetPasswordModal)
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
            authModel.loginSuccess = false
        }
        else {
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    let err = error?.localizedDescription ?? ""
                    print(err)
                    if (err.contains("no user record")) {
                        loginMessage = "This email hasn't register yet"
                    }
                    loginMessage = "Invalid sign-in credentials"
                    authModel.loginSuccess = false
                } else {
                    print("success")
                    loginMessage = "Log in successfully"
                    authModel.loginSuccess = true
                    authModel.state = .signedIn
                    restaurantModel.requestGeolocationPermission()

                }
            }
        }
    }
    
}
