/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 3
    Author: Tran Mai Nhung
    ID: s3879954
    Created  date: 16/09/2022
    Last modified: 17/09/2022
    Acknowledgement:
    - Canvas
*/

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
