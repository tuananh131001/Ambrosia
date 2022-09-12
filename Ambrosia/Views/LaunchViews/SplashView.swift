//
//  SplashView.swift
//  Ambrosia
//
//  Created by Nhung Tran on 10/09/2022.
//

import SwiftUI

struct SplashView: View {
    let outerCircle: CGFloat = 170.0
    let innerCircle: CGFloat = 125.0
    let outerWidth: CGFloat = 15.0
    let innerWidth: CGFloat = 5.0
    
    @State var animationValues: [Bool] = Array(repeating: false, count: 10)
    
    let nearFinalIndex = 6
    let finalIndex = 7
    
    @State private var title = "A"
    @State private var title2 = ""
    @State private var footer = "I"
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Home View
                LaunchView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .offset(y: animationValues[nearFinalIndex] ? 0 : (geo.size.height + 50))
                
                if !animationValues[finalIndex] {
                    // Splash View
                    ZStack {
                        Color("Splash BckClr")
                        BackgroundImage()
                            .opacity(0.25)
                        
                        VStack {
                            Spacer()
                            VStack(spacing: 40) {
                                ZStack {
                                    SplashIconImage(name: "splash-spoon", rotateDegree: -44, parentWidth: innerCircle, animationValues: animationValues)
                                        .padding(.trailing, outerCircle + innerCircle / 3.5)
                                    ZStack {
                                        // MARK: Outer circle (dish)
                                        Circle()
                                            .circleBorderStyle(borderClr: "Splash Icon Blur LineClr", borderWidth: outerWidth, circleWidth: outerCircle)
                                            .opacity(animationValues[2] ? Constants.SPLASH_CIRCLE_OPACITY : 0)
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
                                HStack(spacing: 1) {
                                    Text(title)
                                        .tracking(2)
                                        .foregroundColor(.white)
                                    Text(title2)
                                        .tracking(2)
                                        .foregroundColor(.black)
                                }
                                .font(Font.custom("Noteworthy-Light", size: 60))
                                .offset(y: animationValues[3] ? -35 : 0)
                                .opacity(animationValues[3] ? 1 : 0)
                                .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.9), radius: 1, x: 1, y: 3)
                                
                                
                            }
                            
                            Spacer()
                            Text(footer)
                                .font(Font.custom("ChalkboardSE-Regular", size: 20))
                                .offset(y: animationValues[3] ? -35 : 0)
                                .opacity(animationValues[3] ? 1 : 0)
                            
                        }
                    }
                    .opacity(animationValues[nearFinalIndex] ? 0 : 1)
                }
                
            }
            .ignoresSafeArea()
            .onAppear() {
                withAnimation(.interpolatingSpring(mass: 0.4, stiffness: 20, damping: 2, initialVelocity: 7)) {
                    // inner icon
                    animationValues[0] = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    // inner circle
                    withAnimation(.easeInOut(duration: 0.3).delay(0.1)) {
                        animationValues[1] = true
                    }
                    // outer circle
                    withAnimation(.easeInOut(duration: 0.3).delay(0.45)) {
                        animationValues[2] = true
                    }
                    // text moving up
                    withAnimation(.easeInOut(duration: 0.4).delay(0.4)) {
                        animationValues[3] = true
                        footer = "Illuminati Group".uppercased()
                    }
                    // text appear horizontally
                    withAnimation(.spring(response: 1, dampingFraction: 0.45, blendDuration: 0.4).delay(1)) {
                        //                        title = "Ambrosia"
                        title = "Ambr".uppercased()
                        title2 = "osia".uppercased()
                        animationValues[4] = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation(.interpolatingSpring(mass: 1, stiffness: 20, damping: 1.3, initialVelocity: 3).delay(0.9)) {
                                animationValues[5] = true
                            }
                        }
                    }
                    
                    
                    // restoring back
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                        withAnimation(.easeInOut(duration: 0.3).delay(0.4)) {
                            animationValues[3] = false
                        }
                        // end splash screen
                        withAnimation(.easeInOut(duration: 0.5).delay(0.8)) {
                            animationValues[nearFinalIndex] = true
                        }
                        
                        // for removing splash view after 2s
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            animationValues[finalIndex] = true
                        }
                        
                    }
                }
                
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
