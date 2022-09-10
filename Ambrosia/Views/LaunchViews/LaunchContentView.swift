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
    @State private var showingSignUpSheet = false
    var openSetting = false
    var body: some View {
        ZStack {
            // for card
            Rectangle()
                .foregroundColor(Color("BackgroundViewColor"))

            VStack (spacing: 30) {

                Spacer()

                // Login fields to sign in
                Group {
                    TextField("Email", text: $email)
                    SecureField("Password", text: $password)
                }

                // Login button
                Button {
                    login()

                } label: {
                    Text("Sign in")
                        .bold()
                        .frame(width: 360, height: 50)
                        .background(.thinMaterial)
                        .cornerRadius(10)
                }

                // Login message after pressing the login button
                if model.loginSuccess {
                    Text("Login Successfully! ✅")
                        .foregroundColor(.green)
                    // open app setting

                } else {
                    Text("Not Login Succeessfully Yet! ❌")
                        .foregroundColor(.red)
                }

                Spacer()

                // Button to show the sign up sheet
                Button {
                    showingSignUpSheet.toggle()
                } label: {
                    Text("Sign Up Here!")
                }
                // MARK: Name of the app
//                AppNameView()


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


                // MARK: gif
                GifView(name: "cat-eat")
                    .frame(width: 173, height: 142)


                Spacer()
            }
                .frame(width: 250)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
        }.sheet(isPresented: $showingSignUpSheet) {
            SignUpView()
        }
            .ignoresSafeArea(.all, edges: .all)

    }
    // Login function to use Firebase to check username and password to sign in
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                model.loginSuccess = false
            } else {
                print("success")
                model.loginSuccess = true
                model.requestGeolocationPermission()
            }
        }
    }
}
