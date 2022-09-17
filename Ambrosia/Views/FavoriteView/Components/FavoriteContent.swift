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
            VStack(alignment: .leading) {
                // MARK: open state
                FavoriteOpen(isOpen: rest.temporarilyClosed == false)
                
                // MARK: title
                Text(rest.title)
                    .font(.title3)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                    .foregroundColor(Constants.TEXT_COLOR)
                
                // MARK: side info
                FavoriteSideInfo(rest: rest)
            }
            
            
            // MARK: Image
            FavoriteImage(cardWidth: imageSize, cardHeight: imageSize, displayType: "")
                .frame(width: imageSize, height: imageSize, alignment: .leading)
                .clipShape(Circle())
            Spacer()
        }
    }
}
