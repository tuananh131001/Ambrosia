/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 3
    Author: Tran Mai Nhung
    ID: s3879954
    Created  date: 16/09/2022
    Last modified: 17/09/2022
    Acknowledgement:
    - Canvas
    - https://betterprogramming.pub/swiftui-app-theme-switch-241a79574b87
*/
import SwiftUI

struct ThemeViewUtil {
    static func setAppTheme(_ userModel: UserModel) {
        //MARK: use saved device theme from toggle
        userModel.user.isDarkModeOn = UserDefaultsUtils.shared.getDarkMode()
        changeDarkMode(state: userModel.user.isDarkModeOn)
    }
    static func changeDarkMode(state: Bool) {
        (UIApplication.shared.connectedScenes.first as?
            UIWindowScene)?.windows.first!.overrideUserInterfaceStyle = state ? .dark : .light
        UserDefaultsUtils.shared.setDarkMode(enable: state)
    }
}
