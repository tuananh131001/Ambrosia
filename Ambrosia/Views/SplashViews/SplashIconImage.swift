//
//  SplashIconImage.swift
//  Ambrosia
//
//  Created by Nhung Tran on 12/09/2022.
//

import SwiftUI

struct SplashIconImage: View {
    let name: String
    let rotateDegree: Double
    
    let parentWidth: Double
    let animationValues: [Bool]
    
    var body: some View {
        Image(name)
            .resizable()
            .rotationEffect(.degrees(rotateDegree))
            .aspectRatio(contentMode: .fit)
            .frame(width: parentWidth / 1.3)
            .scaleEffect(animationValues[0] ? 1 : 0, anchor: .bottom)
            .modifier(LightShadowModifier())
    }
}
