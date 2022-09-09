/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Tran Mai Nhung
 ID: s3879954
 Created  date: 02/08/2022
 Last modified: 07/08/2022
 Acknowledgement:
 - Canvas, CodeWithChris Course
 */

import SwiftUI

struct MapDisplayButton: View {
    @Binding var isShowingMap: Bool
    private let frameSize: CGFloat = 60
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                NavigationLink(destination: {
                    // display map view after clicking
                    MapView()
                }, label: {
                    // Button for clicking
                    ZStack {
                        Circle()
                            .foregroundColor(Color("MapButtonBckColor"))
                            .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.6), radius: 5, x: -3, y: 3)
                        Image(systemName: "map.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: frameSize - 32)
                            .foregroundColor(Color("MapButtonColor"))
                    }
                    .frame(width: frameSize, height: frameSize)
                    .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.4), radius: 5, x: -3, y: 3)
                }
                )
            }
            .padding()
        }
        
    }
}
