//
//  FavoriteContent.swift
//  Ambrosia
//
//  Created by Nhung Tran on 16/09/2022.
//

import SwiftUI

struct FavoriteContent: View {
    let imageSize: CGFloat
    let titleSize: CGFloat
    let starSize: CGFloat
    let distanceSize: CGFloat
    let openSize: CGFloat
    
    let contentWidth: CGFloat
    
    let rest: Restaurant
    var body: some View {
        HStack {
            // MARK: image
            FavoriteImage(cardWidth: imageSize, cardHeight: imageSize)
                .frame(width: imageSize)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 3) {
                // MARK: ratding
                FavoriteRating(restaurant: rest, starSize: starSize, titleSize: titleSize)

                // MARK: name
                Text(rest.title)
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color("Fv Title Clr"))
//                    .font(.system(size: titleSize))
                    .font(.title3)

                // MARK: side info
                FavoriteSideInfo(distanceSize: distanceSize, restaurant: rest)

                Spacer()

                // MARK: Open State
                FavoriteOpen(isOpen: true, openSize: openSize)

            }
//                .frame(width: contentWidth)
            
            Spacer()
            
            VStack {
                FavoriteButton(rest: rest)
                Spacer()
            }

        }
        .padding(30)
    }
}
