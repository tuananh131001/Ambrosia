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

            
            // MARK: distance
            Label {
                Text("\(rest.distance, specifier: "%.2f")km")
            } icon: {
                Image(systemName: "car.fill")
            }
            .foregroundColor(Color("SubTextColor"))

        }
        .lineLimit(1)
        .font(.subheadline)
    }
}
