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

struct StaticSplashView: View {
    // splash view without animation
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
