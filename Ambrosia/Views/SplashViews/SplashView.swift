/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 3
    Author: Tran Mai Nhung
    ID: s3879954
    Created  date: 10/09/2022
    Last modified: 17/09/2022
    Acknowledgement:
- Canvas, CodeWithChris Course
*/

import SwiftUI

struct SplashView: View {
    @State var animationValues: [Bool] = Array(repeating: false, count: Constants.SPLASH_ANIMATION_ARRAY)
    
    let nearFinalIndex = 6
    let finalIndex = 7
    
    @State private var outerCircle: CGFloat = 170.0
    @State private var titleSize: CGFloat = 0.0
    @State private var footerSize: CGFloat = 0.0
    
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

//                    .environmentObject(RestaurantModel())
//                    .environmentObject(UserModel())
                
                
                
                if !animationValues[finalIndex] {
                    // MARK: - Splash View
                    StaticSplashView(animationValues: animationValues, outerCircle: outerCircle, titleSize: titleSize, footerSize: footerSize, title: title, title2: title2, footer: footer)
                    .opacity(animationValues[nearFinalIndex] ? 0 : 1)
                    .onAppear() {
                        outerCircle = geo.size.width / 2.43
                        titleSize = geo.size.width / 6.9
                        footerSize = geo.size.width / 20.6
                    }
                }
                
            }
            .ignoresSafeArea()
            .onAppear() {
                // background music
                SoundModel.startBackgroundMusic(bckName: "login")
                // MARK: - animation
//                withAnimation(.interpolatingSpring(mass: 0.4, stiffness: 20, damping: 2, initialVelocity: 7)) {
                withAnimation(.easeInOut(duration: 0.2).delay(0.1)) {
                    // inner icon
                    animationValues[0] = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    // inner circle
                    withAnimation(.easeInOut(duration: 0.3).delay(0.2)) {
                        animationValues[1] = true
                    }
                    // outer circle
                    withAnimation(.easeInOut(duration: 0.3).delay(0.45)) {
                        animationValues[2] = true
                    }
                    // text moving up
                    withAnimation(.easeInOut(duration: 0.17).delay(0.75)) {
                        animationValues[3] = true
                        footer = "Illuminati Group".uppercased()
                    }
                    // text appear horizontally
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                        withAnimation(.easeInOut(duration: 0.4).delay(0.2)) {
                            title = "Ambr".uppercased()
                            title2 = "osia".uppercased()
                            animationValues[4] = true
                            // trim circle
                            withAnimation(.easeInOut(duration: 0.3).delay(0.4).repeatForever().delay(0.1)) {
                                    animationValues[5] = true
                                }
                        }
                    }

                    // restoring back
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.6) {
                        withAnimation(.easeInOut(duration: 0.2).delay(0.4)) {
                            animationValues[3] = false
                        }
                        // end splash screen
                        withAnimation(.easeInOut(duration: 0.2).delay(0.8)) {
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
