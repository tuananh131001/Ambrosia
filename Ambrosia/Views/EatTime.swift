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

@main
struct EatTime: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        
        WindowGroup {
            LaunchView()
                .environmentObject(RestaurantModel())
                .environmentObject(UserModel())
        }
    }
}
