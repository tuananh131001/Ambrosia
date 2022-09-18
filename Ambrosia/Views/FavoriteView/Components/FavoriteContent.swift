//
//  FavoriteContent.swift
//  Ambrosia
//
//  Created by Nhung Tran on 16/09/2022.
//

import SwiftUI

struct FavoriteContent: View {
    let imageSize: CGFloat
    let rest: Restaurant
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                // MARK: open state
                FavoriteCategory(rest: rest)
                // MARK: title
                Text(rest.title)
                    .font(.title2)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                    .foregroundColor(Constants.TEXT_COLOR)
                
                // MARK: side info
                FavoriteSideInfo(rest: rest)
                Spacer()
                
                // MARK: rating
                FavoriteRating(restaurant: rest)
            }
            .frame(height: imageSize)
            
            Spacer()
            
            // MARK: Image
//            FavoriteImage(cardWidth: imageSize, cardHeight: imageSize, displayType: "")
            RestaurantAsyncImage(photo_id: rest.imageLink )
                .frame(width: imageSize, height: imageSize, alignment: .leading)
                .cornerRadius(Constants.CONRNER_RADIUS)
        }
    }
}
