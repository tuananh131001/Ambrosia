//
//  SettingView.swift
//  Ambrosia
//
//  Created by Võ Quốc Huy on 11/09/2022.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var userModel: UserModel
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Button {
                userModel.SignOut()
                // background music
                SoundModel.startBackgroundMusic(bckName: "login")
            } label: {
                Text("SIGN OUT")
                    .bold()
            }
            .buttonStyle(ButtonStylePrimary())
        }
        
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
