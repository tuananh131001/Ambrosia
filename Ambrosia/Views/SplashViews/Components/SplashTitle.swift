/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 3
    Author: Tran Mai Nhung
    ID: s3879954
    Created  date: 12/09/2022
    Last modified: 17/09/2022
    Acknowledgement:
    - Canvas
*/

import SwiftUI

struct SplashTitle: View {
    let animationValues: [Bool]
    let title: String
    let title2: String
    let titleFont: CGFloat
    
    var body: some View {
        HStack(spacing: 1) {
            Text(title)
                .tracking(2)
                .foregroundColor(.white)
                .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.9), radius: 1, x: 1, y: 3)
            Text(title2)
                .tracking(2)
                .foregroundColor(.black)
                .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.7), radius: 1, x: 1, y: 3)
        }
        .font(Font.custom("Noteworthy-Light", size: titleFont))
        .offset(y: animationValues[3] ? -35 : 0)
        .opacity(animationValues[3] ? 1 : 0)
    }
}
