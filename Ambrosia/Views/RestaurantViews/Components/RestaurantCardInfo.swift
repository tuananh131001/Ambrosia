//
//  RestaurantCardInfo.swift
//  Ambrosia
//
//  Created by William on 09/09/2022.
//

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
                Text(rest.name)
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

