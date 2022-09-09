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

struct RestaurantSearchCardView: View {
    var rest: Restaurant
    var body: some View {
        ZStack {
            //MARK: container
            Rectangle()
                .foregroundColor(Color("RestCardBckColor"))
            
            // MARK: restaurant information
            HStack(spacing: 3) {
                
                // image
                Image("\(rest.name)-bck")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 140)
                    .clipped()
                Spacer()
                
                VStack(alignment: .leading) {
                    Spacer()
                    // MARK: name of the restaurants
                    Text(rest.name)
                        .font(.title3)
                        .bold()
                        .lineLimit(1)
                        .foregroundColor(Color("RestCardTitleColor"))
                    
                    // MARK: rating of the restaurant and distance
                    RatingView(rest: rest)
                    
                    Spacer()
                }
                Spacer()
            }
            
            
        }
        .frame(height: 130)
        .cornerRadius(15)
        .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.17), radius: 10, x: -5, y: 10)
    }
}
