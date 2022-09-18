//
//  ToggleTheme.swift
//  Ambrosia
//
//  Created by Nhung Tran on 16/09/2022.
//

import SwiftUI

struct ToggleTheme: View {
    @EnvironmentObject var userModel: UserModel
    
    // MARK: set theme dark light mode
    var body: some View {
        Toggle("Dark Mode", isOn: $userModel.user.isDarkModeOn)
            .foregroundColor(Color("TextColor"))
            .onChange(of: userModel.user.isDarkModeOn) { (state) in
                ThemeViewUtil.changeDarkMode(state: state)
                userModel.updateUserThemeMode()
        }
            .labelsHidden()
            .toggleStyle(SwitchToggleStyle(tint: Constants.PRIMARY_COLOR))
    }
}
