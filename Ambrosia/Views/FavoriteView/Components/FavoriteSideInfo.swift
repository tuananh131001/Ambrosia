//
//  FavoriteSideInfo.swift
//  Ambrosia
//
//  Created by Nhung Tran on 16/09/2022.
//

import SwiftUI

struct FavoriteSideInfo: View {
    var rest: Restaurant

    var body: some View {
        HStack {
            // MARK: rating
            Label {
                Text("\(rest.totalScore ?? 0.0, specifier: "%.1f")")
                    .foregroundColor(Constants.SECONDARY_COLOR)
            } icon: {
                Image(systemName: "star.fill")
                    .foregroundColor(Constants.PRIMARY_COLOR)
            }
            
            // MARK: separator
            Text("❋")
                .font(.title2)
                .foregroundColor(Color("SubTextColor2"))

            // MARK: distance
            Label {
                Text("\(rest.distance, specifier: "%.2f")km")
            } icon: {
                Image(systemName: "bicycle")
            }
            .foregroundColor(Color("SubTextColor2"))

        }
        .lineLimit(1)
        .font(.headline)
    }
}
