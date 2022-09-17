//
//  LoginView.swift
//  Ambrosia
//
//  Created by Khanh Tran Nguyen Ha on 10/09/2022.
//

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

    var body: some View {
        ZStack (alignment: .center) {
//            Rectangle()
//                .foregroundColor(Constants.PRIMARY_COLOR)
            GeneralBackground()
            VStack {
                InformationForm()
                // MARK: LOGIN BUTTON
                Button {
                    // add sound effect when click button
                    SoundModel.clickButtonSound()
                    
                    guard let userId = Auth.auth().currentUser?.uid else { return }
                    userModel.user.id = userId
                    userModel.firebaseService.updateUser(user: userModel.user)
                    userModel.isNewUser = false
                    
                    message = "Profile is updated successfully ✅"
                    showMessage = true
                } label: {
                    Text("Confirm Changes").bold()
                }
                .buttonStyle(ButtonStyleWhite())
                
                if(showMessage) {
                    Text(message)
                        .foregroundColor(.yellow)
                }
            }
        }
    }
}

struct EditInformation_Previews: PreviewProvider {
    static var previews: some View {
        EditInformation()
    }
}
