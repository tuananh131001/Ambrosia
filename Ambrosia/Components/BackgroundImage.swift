//
//  BackgroundImage.swift
//  Ambrosia
//
//  Created by Nhung Tran on 12/09/2022.
//

import SwiftUI

struct BackgroundImage: View {
    var name: String = "launch"
    var brightness: CGFloat = -0.75
    var contrast: CGFloat = 0.5
    var opacity: CGFloat = 0.6
    var body: some View {
        Color.clear.overlay(
            Image(name)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .brightness(brightness)
                .contrast(contrast)
                .opacity(opacity)
        )
            .edgesIgnoringSafeArea(.all)
    }
}
