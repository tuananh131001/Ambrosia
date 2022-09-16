//
//  FavoriteOpen.swift
//  Ambrosia
//
//  Created by Nhung Tran on 16/09/2022.
//

import SwiftUI

struct FavoriteOpen: View {
    var isOpen: Bool
    let openSize: CGFloat
    var body: some View {
        Label {
            Text(isOpen ? "OPEN" : "CLOSED")
                .foregroundColor(Color("\(isOpen ? "Open" : "Close") Color"))
                .font(.system(size: openSize))
        } icon: {
            ImageSystemHier(name: "clock.badge.checkmark.fill", color: "Fv Subtitle Clr 2", size: openSize + 1)
        }

    }
}
