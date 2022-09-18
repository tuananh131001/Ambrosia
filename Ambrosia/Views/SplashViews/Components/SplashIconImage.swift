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

struct SplashIconImage: View {
    // for icon inside logo
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
