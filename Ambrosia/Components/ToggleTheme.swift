/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 3
 Author:  Tran Mai Nhung
 ID: s3879954
 Created  date: 14/09/2022
 Last modified: 16/09/2022
 Acknowledgement:
 - Canvas
 -  https://betterprogramming.pub/swiftui-app-theme-switch-241a79574b87
 */

import SwiftUI

struct ToggleTheme: View {
    // for switching dark + light mode
    @EnvironmentObject var userModel: UserModel
    
    // MARK: set theme dark light mode
    var body: some View {
        Toggle("Dark Mode", isOn: $userModel.user.isDarkModeOn)
            .foregroundColor(Color("TextColor"))
            .onChange(of: userModel.user.isDarkModeOn) { (state) in
                SoundModel.clickTabSound()
                ThemeViewUtil.changeDarkMode(state: state)
                userModel.updateUserThemeMode()
            }
            .labelsHidden()
            .toggleStyle(SwitchToggleStyle(tint: Constants.PRIMARY_COLOR))
    }
}
