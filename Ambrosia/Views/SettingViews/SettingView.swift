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

    var body: some View {
        ZStack {
            Constants.BCK_COLOR
            VStack (spacing: 10) {
                Text("Hello \(userModel.user.name)!")


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

    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
