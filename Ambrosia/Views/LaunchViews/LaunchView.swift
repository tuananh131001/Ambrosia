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

    // splashsreen here
    var body: some View {
        // if app has not ask user permission to access location
        if !userModel.loginSuccess {
            LaunchContentView()
        }
        else if userModel.loginSuccess && restaurantModel.authorizationState == .notDetermined {

            LaunchContentView(openSetting: true)
        }
        else if userModel.loginSuccess && userModel.isNewUser {
            EditInformation()
        }
        else if userModel.loginSuccess && !userModel.isNewUser {
//                ReviewView(reviews: Review.testReviews())
            HomeView()
        }
        // user not allow -> open settings

    }

}
