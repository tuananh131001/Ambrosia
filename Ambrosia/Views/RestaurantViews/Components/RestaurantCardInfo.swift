/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 3
 Author: Nguyen Tuan Anh, Vo Quoc Huy
 ID: s3864077, s3823236
 Created  date: 9/09/2022
 Last modified: 17/09/2022
 Acknowledgement:
 - Canvas
 */

import SwiftUI

struct RestaurantCardInfo: View {
    var rest: Restaurant
    var cardWidth: CGFloat
    var cardHeight: CGFloat
    var displayType: String
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                // MARK: restaurant name
                Text(rest.title)
                    .font(displayType == "all" ? .title2 : .title3)
                    .bold()
                    .lineLimit(1)
                    .foregroundColor(Color("PrimaryColor"))
                
                Spacer()
                
            }
            .padding(.top, 10)
            Spacer()
            HStack(spacing: 0) {
                HStack(spacing: 5) {
                    // MARK: restaurant rating
                    //                    RatingView(rest: rest)
                    Text("•")
                        .font(.headline)
                        .bold()
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .font(.subheadline)
            
        }
        .frame(width: cardWidth)
    }
}

