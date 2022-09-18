/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 3
 Author: Tran Mai Nhung
 ID: s3879954
 Created  date: 12/09/2022
 Last modified: 14/09/2022
 Acknowledgement:
 - Canvas
 */


import SwiftUI

struct BackgroundImage: View {
    // reusable for displaying image as background in the view
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
