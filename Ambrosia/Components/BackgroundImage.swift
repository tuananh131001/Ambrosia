//
//  BackgroundImage.swift
//  Ambrosia
//
//  Created by Nhung Tran on 12/09/2022.
//

import SwiftUI

struct BackgroundImage: View {
    var name: String = "launch"
    var body: some View {
        Color.clear.overlay(
            Image(name)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .brightness(-0.75)
                .contrast(0.5)
                .opacity(0.6)
        )
            .edgesIgnoringSafeArea(.all)
    }
}

struct BackgroundImage_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundImage()
    }
}
