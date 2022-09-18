/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 3
    Author: Tran Mai Nhung
    ID: s3879954
    Created  date: 12/09/2022
    Last modified: 12/09/2022
    Acknowledgement:
    - Canvas
*/


import SwiftUI

struct GeneralLogoView: View {
    let animationValues: [Bool]
    let outerCircle: CGFloat

    let innerCircle: CGFloat
    let innerWidth: CGFloat
    let outerWidth: CGFloat

    init(outerCircle: CGFloat, animationValues: [Bool] = Array(repeating: false, count: Constants.SPLASH_ANIMATION_ARRAY)) {
        self.animationValues = animationValues
        self.outerCircle = outerCircle
        
        self.innerCircle = outerCircle / 1.36
        self.outerWidth = outerCircle / 11.3333
        self.innerWidth = self.outerWidth / 3
    }

    var body: some View {
        ZStack {
            SplashIconImage(name: "splash-spoon", rotateDegree: -44, parentWidth: innerCircle, animationValues: animationValues)
                .padding(.trailing, outerCircle + innerCircle / 3.5)
            
            ZStack {
                // MARK: Outer circle (dish)
                Circle()
                    .circleBorderStyle(borderClr: "Splash Icon Blur LineClr", borderWidth: outerWidth, circleWidth: outerCircle)
                    .opacity(animationValues[2] ? Constants.SPLASH_CIRCLE_OPACITY: 0)
                Circle()
                    .trimCircleBorderStyle(checkConditionTrim: animationValues[5], start: 0.19, end: 0.89, borderClr: "Splash Icon LineClr", borderWidth: outerWidth, circleWidth: outerCircle)
                    .opacity(animationValues[2] ? 1 : 0)

                // MARK: Inner Circle (bowl)
                Circle()
                    .circleBorderStyle(borderClr: "Splash Icon LineClr", borderWidth: innerWidth, circleWidth: innerCircle)
                    .background(Circle().fill(Color("Splash Icon BckClr")))
                    .modifier(LightShadowModifier())
                    .opacity(animationValues[1] ? 1 : 0)


                SplashIconImage(name: "splash-map-icon", rotateDegree: 0, parentWidth: innerCircle, animationValues: animationValues)
                    .frame(width: innerCircle / 1.8)

            }
            .scaleEffect(animationValues[2] ? 0.75 : 1)
            .drawingGroup()
            
            SplashIconImage(name: "splash-chopsticks", rotateDegree: 134, parentWidth: innerCircle, animationValues: animationValues)
                .padding(.leading, outerCircle + innerCircle / 3.5)
        }
    }
}
