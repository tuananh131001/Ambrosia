/*
     RMIT University Vietnam
     Course: COSC2659 iOS Development
     Semester: 2022B
     Assessment: Assignment 3
     Author: Tran Mai Nhung, Tran Nguyen Ha Khanh, Nguyen Tuan Anh
     ID: s3879954, s3877707, s3864077
     Created  date: 9/09/2022
     Last modified: 17/09/2022
     Acknowledgement:
     - Canvas
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
        }
        else if userModel.loginSuccess && userModel.isNewUser {
            EditInformation()
        }
        else if userModel.loginSuccess && !userModel.isNewUser {

            HomeView()
                .onAppear() {
                // background music
                SoundModel.startBackgroundMusic(bckName: "home")
            }
        }

    }
        

}
