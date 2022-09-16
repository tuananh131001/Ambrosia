//
//  SettingView.swift
//  Ambrosia
//
//  Created by Võ Quốc Huy on 11/09/2022.
//
import SwiftUI
import Firebase

struct SettingView: View {
    @EnvironmentObject var userModel: UserModel
    @State var showEditInfo: Bool = false
    @State var showReviewList: Bool = false
    
    var body: some View {
        ZStack {
            VStack (spacing: 10) {
                Text("Hello \(userModel.user.name)!")

                // MARK: EDIT INFO BTN
                Button {
                    showReviewList = true

                } label: {
                    Text("Show recent review").bold()
                }
                    .buttonStyle(ButtonStylePrimary())
                // MARK: EDIT INFO BTN
                Button {
                    showEditInfo = true

                } label: {
                    Text("Edit Profile").bold()
                }
                    .buttonStyle(ButtonStylePrimary())

                // MARK: SIGN OUT BTN
                Button {
                    // background music
                    SoundModel.startBackgroundMusic(bckName: "login")
                    // sound effect
                    SoundModel.clickCardSound()
                    userModel.SignOut()
                } label: {
                    Text("Sign Out")
                        .bold()
                }
                    .buttonStyle(ButtonStylePrimary())
            }

        }
            .sheet(isPresented: $showEditInfo) {
            EditInformation()
        }
            .sheet(isPresented: $showReviewList){
                DistrictFilterView()
            }

    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
