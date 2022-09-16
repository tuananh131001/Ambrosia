//
//  SettingView.swift
//  Ambrosia
//
//  Created by Võ Quốc Huy on 11/09/2022.
//
import SwiftUI
import Firebase

struct SettingView: View {
    @EnvironmentObject var userModel: UserModel
    @State var showEditInfo: Bool = false
    @State var showReviewList: Bool = false

    // for dark light mode
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    // MARK: set theme dark light mode
    func setAppTheme() {
        //MARK: use saved device theme from toggle
        userModel.user.isDarkModeOn = UserDefaultsUtils.shared.getDarkMode()
        changeDarkMode(state: userModel.user.isDarkModeOn)
        //MARK: or use device theme
        if (colorScheme == .dark)
        {
            userModel.user.isDarkModeOn = true
        }
        else {
            userModel.user.isDarkModeOn = false
        }
        changeDarkMode(state: userModel.user.isDarkModeOn)
    }
    func changeDarkMode(state: Bool) {
        (UIApplication.shared.connectedScenes.first as?
            UIWindowScene)?.windows.first!.overrideUserInterfaceStyle = state ? .dark : .light
        UserDefaultsUtils.shared.setDarkMode(enable: state)
    }
    var ToggleTheme: some View {
        Toggle("Dark Mode", isOn: $userModel.user.isDarkModeOn)
            .foregroundColor(Color("TextColor"))
            .onChange(of: userModel.user.isDarkModeOn) { (state) in
            changeDarkMode(state: state)
            userModel.updateUserThemeMode()
        }.labelsHidden()
    }

    
    var body: some View {
        ZStack {
            Constants.BCK_COLOR
            VStack (spacing: 10) {
                // MARK: light dark mode view switch
                ToggleTheme
                
                Text("Hello \(userModel.user.name)!")

                // MARK: EDIT INFO BTN
                Button {
                    showReviewList = true

                } label: {
                    Text("Show recent review").bold()
                }
                    .buttonStyle(ButtonStylePrimary())
                // MARK: EDIT INFO BTN
                Button {
                    showEditInfo = true

                } label: {
                    Text("Edit Profile").bold()
                }
                    .buttonStyle(ButtonStylePrimary())

                // MARK: SIGN OUT BTN
                Button {
                    // background music
                    SoundModel.startBackgroundMusic(bckName: "login")
                    // sound effect
                    SoundModel.clickCardSound()
                    userModel.SignOut()
                } label: {
                    Text("Sign Out")
                        .bold()
                }
                    .buttonStyle(ButtonStylePrimary())
            }

        }
            .sheet(isPresented: $showEditInfo) {
            EditInformation()
        }
            .sheet(isPresented: $showReviewList) {
            RecentReviews()
        }
            .onAppear(perform: {
            setAppTheme()
        })
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
