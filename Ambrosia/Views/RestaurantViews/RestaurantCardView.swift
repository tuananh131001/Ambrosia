/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Tran Mai Nhung
 ID: s3879954
 Created  date: 29/07/2022
 Last modified: 07/08/2022
 Acknowledgement:
 - Canvas, CodeWithChris Course
 */

import SwiftUI
//extension View {
//    func multicolorGlow() -> some View {
//        ZStack {
//            ForEach(0..<2) { i in
//                Rectangle()
//                    .fill(AngularGradient(gradient: Gradient(colors:
//                                                                [Color.blue, Color.purple, Color.orange, Color.red]), center: .center))
//                    .frame(width: 400, height: 300)
//                    .mask(self.blur(radius: 20))
//                    .overlay(self.blur(radius: 5 - CGFloat(i * 5)))
//            }
//        }
//    }
//}
struct RestaurantCardView: View {
    var rest: Restaurant
    @EnvironmentObject var model: RestaurantModel
    var cardWidth: CGFloat
    var cardHeight: CGFloat
    var displayType: String
    
    var body: some View {
        // Card content
        // add display gone or not gone
        VStack(alignment: .center, spacing: 5) {
            
            // MARK: cover image
            ZStack {
                Image("\(rest.name)-bck")
                    .resizable()
                    .scaledToFill()
                ImageShadowView()
            }
            .frame(width: cardWidth, height: cardHeight)
            .cornerRadius(10)
            .clipped()
            
            
            // MARK: Text
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    // MARK: restaurant name
                    Text(rest.name)
                        .font(displayType == "all" ? .title2 : .title3)
                        .bold()
                        .lineLimit(1)
                        .foregroundColor(Color("RestCardTitleColor"))
                    Spacer()

                    
                }
                .padding(.top, 10)
                
                Spacer()
                HStack(spacing: 0) {
                    HStack(spacing: 5) {
                        
                        // MARK: restaurant rating
                        RatingView(rest: rest)
                        
                        Text("•")
                            .font(.headline)
                            .bold()
                            .foregroundColor(.black)
                        
                        // MARK: restaurant category
                        if displayType == "all" {
                            Text(rest.categories[0])
                                .foregroundColor(Color("RestCardCaptColor"))
                                .italic()
                        }
                    }
                    Spacer()
                }
                .font(.subheadline)
                
            }
            .frame(width: cardWidth)
            
            // MARK: divider
            if displayType == "all" {
                Divider()
                    .frame(width: cardWidth, height: 1.7)
                    .overlay(Color("RestCardBorderColor"))
                    .cornerRadius(10)
                    .padding(.vertical, 10)
            }
        }
        .background(Color("RestCardBckColor"))
        .cornerRadius(20)
        .padding(.horizontal)
        .frame(width: cardWidth)
        
    }
}
