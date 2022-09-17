//
//  FavoriteOpen.swift
//  Ambrosia
//
//  Created by Nhung Tran on 16/09/2022.
//

import SwiftUI

struct FavoriteOpen: View {
    var isOpen: Bool
    var body: some View {
        Label {
            Text(isOpen ? "OPEN" : "CLOSED")
        } icon: {
            Image(systemName: "circle.fill")
        }
        .foregroundColor(Color("\(isOpen ? "Open" : "Close")Color"))
        .font(.caption)

    }
}
