/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Tran Mai Nhung
 ID: s3879954
 Created  date: 29/07/2022
 Last modified: 07/08/2022
 Acknowledgement:
 - Canvas, CodeWithChris Course
 */

import SwiftUI

struct AppNameView: View {
    var txtColor: Color = Color.white
    let circleFrame: CGFloat = 330
    var body: some View {
        // display name in splash screen
        ZStack {
            Image("launch")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
                .frame(width: circleFrame, height: circleFrame)
                .brightness(-0.39)
                .contrast(0.5)
                .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.5), radius: 10, x: -5, y: 5)
            
            
            Text("Ambrosia".uppercased())
                .font(Font.custom("Avenir", size: 100))
                .tracking(2)
                .bold()
                .foregroundColor(txtColor)
                .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.5), radius: 10, x: -5, y: 5)
            
        }
    }
}

