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

struct SplashFooter: View {
    // footer in splash view
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
