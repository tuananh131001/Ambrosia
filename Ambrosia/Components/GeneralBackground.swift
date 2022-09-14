//
//  GeneralBackground.swift
//  Ambrosia
//
//  Created by Nhung Tran on 14/09/2022.
//

import SwiftUI

struct GeneralBackground: View {
    var body: some View {
        ZStack {
            Color("Splash BckClr")
            BackgroundImage()
                .opacity(0.25)
        }
    }
}

struct GeneralBackground_Previews: PreviewProvider {
    static var previews: some View {
        GeneralBackground()
    }
}
