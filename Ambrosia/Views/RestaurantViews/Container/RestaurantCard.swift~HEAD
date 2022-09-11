/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Tran Mai Nhung
 ID: s3879954
 Created  date: 29/07/2022
 Last modified: 07/08/2022
 Acknowledgement:
 - Canvas, CodeWithChris Course
 */
import SwiftUI

struct RestaurantCard: View {
    var rest: Restaurant
    var cardWidth: CGFloat = UIScreen.main.bounds.width - 30
    var cardHeight: CGFloat = 357
    var displayType: String = "all"
    
    var body: some View {
        // Card content
        // add display gone or not gone
        VStack(alignment: .center, spacing: 5) {
            // MARK: cover image
            RestaurantAsyncImage(photo_id: rest.photos?[0].photo_reference ?? "").frame(width: cardWidth, height: cardHeight)
                .cornerRadius(10)
                .clipped()
            // MARK: Text
            RestaurantCardInfo(rest: rest, cardWidth: cardWidth, cardHeight: cardHeight, displayType: displayType)
            // MARK: divider
            if displayType == "all" {
                Divider()
                    .frame(width: cardWidth, height: 1.7)
                    .overlay(Color("RestCardBorderColor"))
                    .cornerRadius(10)
                    .padding(.vertical, 10)
            }
        }
            .background(Color("RestCardBckColor"))
            .cornerRadius(20)
            .padding(.horizontal)
            .frame(width: cardWidth)
    }
}


