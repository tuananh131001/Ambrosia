//
//  ThemeViewUtil.swift
//  Ambrosia
//
//  Created by Nhung Tran on 16/09/2022.
//

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
