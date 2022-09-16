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
                                Text(userModel.loginMessage)
                                    .foregroundColor(userModel.loginSuccess ? .green : .red)
                            }
                        }

                        VStack (spacing: 10) {

                            // MARK: BTN FORGET
                            Button {
                                SoundModel.clickOtherSound()

                                showForgetPasswordModal = true
                            } label: {
                                Text("Forget password?")
                            }

                            // MARK: BTN LOGIN
                            Button {
                                SoundModel.clickButtonSound()
                                // add sound effect when click button
//                                NormalSignIn(email: email, password: password)
//                                showLoginMessage = true
                                login(type: .normal)
                            } label: {
                                Text("Sign In")
                                    .bold()
                            }
                                .buttonStyle(ButtonStylePrimary())


                            // MARK: BTN GOOGLE
                            Button {
                                // add sound effect when click button
                                SoundModel.clickButtonSound()
//                                userModel.GoogleSignIn()
//                                if (userModel.loginSuccess) {
//                                    restaurantModel.requestGeolocationPermission()
//                                }
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
                                // add sound effect when click button
                                SoundModel.clickButtonSound()
//                                userModel.MicrosoftSignIn()
//                                if (userModel.loginSuccess) {
//                                    restaurantModel.requestGeolocationPermission()
//                                }
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
            .onAppear(perform: {
            if (UserDefaults.standard.string(forKey: "loginType") == "normal") {
                DispatchQueue.main.async {
                    userModel.autoLoginNormal(restaurantModel: restaurantModel)
                    if (userModel.loginSuccess) {
                        print("Login sir")
                        
                        print("Inside launch sir", userModel.userId, userModel.user)
                        userModel.state = .signedIn
                        restaurantModel.requestGeolocationPermission()
                    }
                }
            }
        })
    }


    func login(type: SignInMethod) {
        userModel.loginMessage = ""
        if (type == .google) {
            userModel.GoogleSignIn(restaurantModel: restaurantModel)
            afterCheckLogin()
        }
        else if (type == .microsoft) {
            userModel.MicrosoftSignIn(restaurantModel: restaurantModel)
            afterCheckLogin()
        }
        else {
            let group = DispatchGroup()
            let queueVerify = DispatchQueue(label: "verify")
            let queueRequest = DispatchQueue(label: "request")

            group.enter()
            queueVerify.async (group: group) {
                userModel.NormalSignIn(email: email, password: password, restaurantModel: restaurantModel)
                group.leave()
            }

            group.enter()
            queueRequest.asyncAfter(deadline: .now() + 0.5) {
                afterCheckLogin()
                group.leave()
            }
        }
    }

    func afterCheckLogin() {
        if (userModel.loginMessage != "") {
            showLoginMessage = true
        }
        else {
            showLoginMessage = false
        }
        if (userModel.loginSuccess) {
            userModel.state = .signedIn
            restaurantModel.requestGeolocationPermission()
        }
    }


}
