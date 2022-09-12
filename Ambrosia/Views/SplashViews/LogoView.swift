//
//  SplashCircles.swift
//  Ambrosia
//
//  Created by Nhung Tran on 12/09/2022.
//

import SwiftUI

//struct LogoView: View {
//    var body: some View {
//        ZStack {
//            SplashIconImage(name: "splash-spoon", rotateDegree: -44, parentWidth: innerCircle, animationValues: animationValues)
//                .padding(.trailing, outerCircle + innerCircle / 3.5)
//            ZStack {
//                // MARK: Outer circle (dish)
//                Circle()
//                    .circleBorderStyle(borderClr: "Splash Icon Blur LineClr", borderWidth: outerWidth, circleWidth: outerCircle)
//                    .opacity(animationValues[2] ? Constants.SPLASH_CIRCLE_OPACITY : 0)
//                Circle()
//                    .trimCircleBorderStyle(checkConditionTrim: animationValues[5], start: 0.19, end: 0.89, borderClr: "Splash Icon LineClr", borderWidth: outerWidth, circleWidth: outerCircle)
//                    .opacity(animationValues[2] ? 1 : 0)
//
//                // MARK: Inner Circle (bowl)
//                Circle()
//                    .circleBorderStyle(borderClr: "Splash Icon LineClr", borderWidth: innerWidth, circleWidth: innerCircle)
//                    .background(Circle().fill(Color("Splash Icon BckClr")))
//                    .modifier(LightShadowModifier())
//                    .opacity(animationValues[1] ? 1 : 0)
//
//                
//                SplashIconImage(name: "splash-map-icon", rotateDegree: 0, parentWidth: innerCircle, animationValues: animationValues)
//                    .frame(width: innerCircle / 1.8)
//
//            }
//    }
//}
