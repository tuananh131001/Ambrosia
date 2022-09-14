//
//  SplashFooter.swift
//  Ambrosia
//
//  Created by Nhung Tran on 14/09/2022.
//

import SwiftUI

struct SplashFooter: View {
    let animationValues: [Bool]
    let footer: String
    let footerFont: CGFloat
    
    var body: some View {
        Text(footer)
            .font(Font.custom("ChalkboardSE-Regular", size: footerFont))
            .offset(y: animationValues[3] ? -35 : 0)
            .opacity(animationValues[3] ? 1 : 0)
    }
}
