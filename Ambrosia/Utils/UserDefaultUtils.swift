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

class UserDefaultsUtils {
    static var shared = UserDefaultsUtils()
    func setDarkMode(enable: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(enable, forKey: Constants.DARK_MODE)
    }
    func getDarkMode() -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: Constants.DARK_MODE)
    }
    
}
