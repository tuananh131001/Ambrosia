//
//  SplashTitle.swift
//  Ambrosia
//
//  Created by Nhung Tran on 14/09/2022.
//

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
            Text(title2)
                .tracking(2)
                .foregroundColor(.black)
        }
        .font(Font.custom("Noteworthy-Light", size: titleFont))
        .offset(y: animationValues[3] ? -35 : 0)
        .opacity(animationValues[3] ? 1 : 0)
        .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.9), radius: 1, x: 1, y: 3)
    }
}
