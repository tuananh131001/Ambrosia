/*
     RMIT University Vietnam
     Course: COSC2659 iOS Development
     Semester: 2022B
     Assessment: Assignment 3
     Author: Tran Nguyen Ha Khanh, Nguyen Tuan Anh, Tran Mai Nhung
     ID: s3877707, s3864077, s3879954
     Created  date: 11/09/2022
     Last modified: 07/09/2022
     Acknowledgement:
     - Canvas
 */
import SwiftUI
import Firebase


struct LaunchContentView: View {
    @EnvironmentObject var restaurantModel: RestaurantModel
    @EnvironmentObject var userModel: UserModel
    
    @StateObject var firebaseService = FirebaseService.services

    @State var email = ""
    @State var password = ""
    @State var showLoginMessage = false
    @State var showingSignUpSheet = false
    @State var showLoginPhoneModal = false
    @State var showForgetPasswordModal = false
    @State var showEnterCodeField = false

    @FocusState private var emailIsFocused: Bool
    @FocusState private var passwordIsFocused: Bool

    var openSetting = false
    var body: some View {
        ZStack (alignment: .center) {
//            Rectangle()
//                .foregroundColor(Constants.PRIMARY_COLOR)
            GeneralBackground()


            // MARK: LOGIN PAGE CONTENT
            ZStack (alignment: .center) {
                ZStack (alignment: .center) {
                    // MARK: LOGIN INPUT FIELDS
                    VStack (spacing: 20) {
                        VStack (spacing: 6) {
                            Text("AMBROSIA")
                                .font(Font(UIFont(name: "Chalkboard SE Bold", size: Constants.APP_NAME_LARGE_SIZE)! as CTFont))
                                
                            Text("It's eat time !")
                                .font(Font(UIFont(name: "Chalkboard SE", size: Constants.APP_NAME_LARGE_SIZE-18)! as CTFont))

                            // MARK: CAT GIF
                            GifView(name: "cat-eat")
                                .frame(width: 130, height: 110)
                        }

                        VStack (spacing: 8) {
                            Group {
                                TextField("Email", text: $email)
                                    .modifier(TextFieldModifier())
                                SecureField("Password", text: $password)
                                    .modifier(TextFieldModifier())
                            }
                                .multilineTextAlignment(.leading)

                            // MARK: LOGIN MESSAGE
                            // Login message after pressing the login button
                            if (showLoginMessage && userModel.loginMessage != "") {
                                Text(userModel.loginMessage)
                                    .foregroundColor(userModel.loginSuccess ? .green : .red)
                            }
                        }

                        VStack (spacing: 8) {
                            
                            // MARK: BTN FORGET
                            Button {
                                SoundModel.clickOtherSound() // sound effect when click button
                                showForgetPasswordModal = true
                            } label: {
                                Text("Forget password?")
                            }

                            // MARK: BTN LOGIN
                            Button {
                                SoundModel.clickButtonSound() // sound effect when click button
                                login(type: .normal)
                            } label: {
                                Text("Sign In")
                                    .bold()
                            }
                                .buttonStyle(ButtonStylePrimary())


                            // MARK: BTN GOOGLE
                            Button {
                                SoundModel.clickButtonSound() // sound effect when click button
                                login(type: .google)
                            } label: {
                                HStack {
                                    Image("gg-icon")
                                    Text("Sign in with Google")
                                        .bold()
                                }
                            }
                                .buttonStyle(ButtonStylePrimary())


                            // MARK: BTN MICROSOFT
                            Button {
                                SoundModel.clickButtonSound() // sound effect when click button
                                login(type: .microsoft)
                            } label: {
                                HStack {
                                    Image("microsoft-icon")
                                    Text("Sign in with Microsoft")
                                        .bold()
                                }
                            }
                                .buttonStyle(ButtonStylePrimary())

                            Text("or")
                                .foregroundColor(.gray)


                            // MARK: BTN REGISTER
                            // Button to show the sign up sheet
                            Button {
                                // add sound effect when click button
                                SoundModel.clickButtonSound()

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
                    .background(Constants.BCK_COLOR)
                    .frame(minWidth: Constants.FIELD_MIN_WIDTH, maxWidth: Constants.FIELD_MAX_WIDTH)
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
            .onAppear(perform: {
                let userDefaults = UserDefaults.standard
                if let loginType = userDefaults.string(forKey: "loginType") {
                    if (loginType != "") {
                        userModel.autoLogin(restaurantModel: restaurantModel, loginType: loginType)
                        afterVerify()
                    }
                }
             })
            .onDisappear(perform: {
                if let uid = Auth.auth().currentUser?.uid {
                    userModel.fetchUserInfo(id: uid, userModel: userModel, restaurantModel: restaurantModel)
                }
            })
    }


    func login(type: SignInMethod) {
        userModel.loginMessage = ""
        if (type == .google) {
            userModel.GoogleSignIn(restaurantModel: restaurantModel)
            afterVerify()
        }
        else if (type == .microsoft) {
            userModel.MicrosoftSignIn(restaurantModel: restaurantModel)
            afterVerify()
        }
        else {
            DispatchQueue.main.async {
                userModel.NormalSignIn(email: email, password: password, restaurantModel: restaurantModel)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                afterVerify()
            }
        }
    }
        
    func afterVerify() {
        showLoginMessage = true
//        showLoginMessage = userModel.loginMessage != "" ? true : false
        if (userModel.loginSuccess) {
            userModel.state = .signedIn
            userModel.fetchUserInfo(id: Auth.auth().currentUser?.uid ?? "uid error", userModel: userModel, restaurantModel: restaurantModel)
//                restaurantModel.requestGeolocationPermission()
        }
        
    }


}
