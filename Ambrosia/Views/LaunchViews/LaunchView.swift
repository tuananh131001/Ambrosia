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

struct LaunchView: View {
    @EnvironmentObject var userModel: UserModel
    @EnvironmentObject var restaurantModel: RestaurantModel

    @StateObject var firebaseService = FirebaseService.services

    @State var isLogging = false
    var body: some View {
        // if app has not ask user permission to access location
        if !userModel.loginSuccess {
            LaunchContentView()
                .onAppear() {
                print("Un login sir")
            }
        }
        else if userModel.loginSuccess && restaurantModel.authorizationState == .notDetermined {
            LaunchContentView(openSetting: true)
        }
        else if userModel.loginSuccess && userModel.isNewUser {
            EditInformation()
                .onAppear() {
                print("Edit ingo sir")
            }
        }
        else if userModel.loginSuccess && !userModel.isNewUser {

            HomeView()
                .onAppear() {
                print("home view sir")
                // fetch current user and store into auth model for later use
//                firebaseService.fetchUser(uid: userModel.userId, restaurantModel: restaurantModel) { user in
//                    userModel.user = user ?? User(id: "", name: "Nothing", dob: Date.now, selectedGender: 0, email: "")
//                }
//                    print("Home view sir", userModel.user)
                // background music
                SoundModel.startBackgroundMusic(bckName: "home")
            }
        }

    }

}
