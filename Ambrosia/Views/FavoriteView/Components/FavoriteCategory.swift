//
//  FavoriteOpen.swift
//  Ambrosia
//
//  Created by Nhung Tran on 16/09/2022.
//

import SwiftUI

struct FavoriteCategory: View {
    var rest: Restaurant
    var body: some View {
        Text(rest.categoryName?.capitalized ?? "Restaurant")
            .foregroundColor(Constants.PRIMARY_COLOR)
            .font(.subheadline)

    }
}
