/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 3
    Author: Tran Nguyen Ha Khanh, Nguyen Tuan Anh
    ID: s3877707, s3864077
    Created  date: 10/09/2022
    Last modified: 17/09/2022
    Acknowledgement:
    - Canvas
*/

import SwiftUI
import Firebase

struct EditInformation: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userModel: UserModel
    
    @State var email = ""
    @State var password = ""

    @State var loginSuccess = false
    
    @State var message = ""
    @State var showMessage = false
    @State var tempName : String = ""
    @State var tempDob : Date = Date()
    @State var tempGender : Int = 1

    var body: some View {
        ZStack (alignment: .center) {
//            Rectangle()
//                .foregroundColor(Constants.PRIMARY_COLOR)
            GeneralBackground()
            VStack (spacing: 20){
                InformationForm(tempName: $tempName, tempDob: $tempDob, tempGender: $tempGender)
                // MARK: LOGIN BUTTON
                Button {
                    // add sound effect when click button
                    SoundModel.clickButtonSound()

                    guard let userId = Auth.auth().currentUser?.uid else { return }
                    userModel.user.name = tempName
                    userModel.user.dob = tempDob
                    userModel.user.selectedGender = tempGender

                    userModel.user.id = userId
                    userModel.firebaseService.updateUser(user: userModel.user)
                    userModel.isNewUser = false
                    
                    message = "Profile is updated successfully ✅"
                    showMessage = true
                } label: {
                    Text("Confirm Changes").bold()
                }
                .buttonStyle(ButtonStyleWhite())
                .frame(maxWidth: Constants.FIELD_MAX_WIDTH)
                .shadow(color: Color("Shadow"), radius: 6.0, x: 2, y: 2)
//                .background(Color("ButtonTextColor"))
                
                if(showMessage) {
                    Text(message)
                        .foregroundColor(.white)
                }
            }
        }
        .onAppear(perform: {
            tempName = userModel.user.name
            tempDob = userModel.user.dob
            tempGender = userModel.user.selectedGender
        })
    }
}

struct EditInformation_Previews: PreviewProvider {
    static var previews: some View {
        EditInformation()
    }
}
