/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 3
    Author: Tran Nguyen Ha Khanh, Vo Quoc Huy, Nguyen Tuan Anh, Tran Mai Nhung
    ID: s3877707, s3823236, s3864077, s3879954
    Created  date: 9/09/2022
    Last modified: 17/09/2022
    Acknowledgement:
- Canvas, CodeWithChris Course
*/

import SwiftUI
import Firebase

@main
struct EatTime: App {
    
//    @StateObject var authModel = FirebaseService()
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        
        WindowGroup {
//            LaunchView()
            SplashView()
//                .preferredColorScheme(isDarkMode ? .dark : .light)
                .environmentObject(UserModel())
                .environmentObject(RestaurantModel())

        }
    }
}
