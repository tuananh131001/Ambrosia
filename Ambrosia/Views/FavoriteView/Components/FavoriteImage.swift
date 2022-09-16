//
//  RestaurantImage.swift
//  Ambrosia
//
//  Created by Nhung Tran on 16/09/2022.
//

import SwiftUI

struct FavoriteImage: View {
    var cardWidth: CGFloat = UIScreen.main.bounds.width - 30
    var cardHeight: CGFloat = 357
    var displayType: String = "all"
    var body: some View {
        ZStack {
            Image("Chuyen Rooftop-bck")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: cardWidth)
            ImageShadowView()
                .opacity(0.8)
        }
    }
}
