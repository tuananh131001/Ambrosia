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
//        Label {
//            Text(isOpen ? "OPEN" : "CLOSED")
//        } icon: {
//            Image(systemName: "circle.fill")
//        }
//        .foregroundColor(Color("\(isOpen ? "Open" : "Close")Color"))
//        .font(.caption)
        Text(rest.categoryName?.capitalized ?? "Restaurant")
            .foregroundColor(Constants.PRIMARY_COLOR)
            .font(.subheadline)

    }
}
