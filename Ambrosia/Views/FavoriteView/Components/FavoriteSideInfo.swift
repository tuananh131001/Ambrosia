//
//  FavoriteSideInfo.swift
//  Ambrosia
//
//  Created by Nhung Tran on 16/09/2022.
//

import SwiftUI

struct FavoriteSideInfo: View {
    var distanceSize: CGFloat
    var restaurant: Restaurant

    var body: some View {
        HStack(spacing: 5) {
            // MARK: Restaurant distance
            Label {
                Text("\(restaurant.distance, specifier: "%.2f")km")
                    .font(.subheadline)
                    .foregroundColor(Color("Fv Subtitle Clr 2"))
            } icon: {
                ImageSystemHier(name: "car.fill", color: "Fv Subtitle Clr 2", size: distanceSize + 1)
            }
        }
        .multilineTextAlignment(.leading)
        .font(.subheadline)
//            .font(.system(size: distanceSize))
            .padding(.top, 3)
    }
}
