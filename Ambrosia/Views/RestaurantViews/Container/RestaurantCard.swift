/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 3
 Author: Vo Quoc Huy, Tran Mai Nhung
 ID: s3823236, s3879954
 Created  date: 9/09/2022
 Last modified: 17/09/2022
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
            RestaurantAsyncImage(photo_id: rest.imageLink ).frame(width: cardWidth, height: cardHeight)
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
            // MARK: Review
            
        }
        .background(Color("RestCardBckColor"))
        .cornerRadius(20)
        .padding(.horizontal)
        .frame(width: cardWidth)
    }
}


