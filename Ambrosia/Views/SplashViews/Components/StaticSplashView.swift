//
//  StaticSplashView.swift
//  Ambrosia
//
//  Created by Nhung Tran on 14/09/2022.
//

import SwiftUI

struct StaticSplashView: View {
    var animationValues: [Bool]
    
    var outerCircle: CGFloat
    var titleSize: CGFloat
    var footerSize: CGFloat
    
    var title: String
    var title2: String
    var footer: String
    
    var body: some View {
        ZStack {
            GeneralBackground()
            VStack {
                Spacer()
                VStack(spacing: 40) {
                    // MARK: logo
                    GeneralLogoView(outerCircle: outerCircle, animationValues: animationValues)
                    // MARK: title
                    SplashTitle(animationValues: animationValues, title: title, title2: title2, titleFont: titleSize)
                }
                Spacer()
                // MARK: footer
                SplashFooter(animationValues: animationValues, footer: footer, footerFont: 20)
            }
        }
    }
}

struct StaticSplashView_Previews: PreviewProvider {
    static var previews: some View {
        StaticSplashView()
    }
}
