/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Tran Mai Nhung
 ID: s3879954
 Created  date: 27/07/2022
 Last modified: 07/08/2022
 Acknowledgement:
 - Canvas, CodeWithChris Course
 */

import SwiftUI

struct FoodCardView: View {
    var food: Food
    var rest: Restaurant
    private let cardHeight: CGFloat = 120
    private let imgWidth: CGFloat = 150
    var body: some View {
        ZStack {
            //MARK: container
            Rectangle()
                .foregroundColor(.white)
            
            // MARK: food information
            HStack {
                
                // information
                VStack(alignment: .leading, spacing: 3) {
                    Text(food.name)
                        .font(.headline)
                        .lineLimit(1)
                        .lineSpacing(1)
                    
                    // Description
                    Text(food.description)
                        .lineLimit(1)
                        .font(.body)
                        .foregroundColor(Color("FoodCardDescriptionColor"))
                    
                    // Price
                    Text("\(food.price)")
                        .font(.subheadline)
                        .foregroundColor(Color("FoodCardPriceColor"))
                        .bold()
                }
                .padding()
                
                Spacer()
                
                // image
                Image(food.description == "" ? food.name : "\(rest.name)-\(food.name)")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: imgWidth, height: cardHeight)
                    .clipped()
                    .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.1), radius: 5, x: -3, y: 3)
                
            }
            
            
        }
        //        .aspectRatio(CGSize(width: 150, height: 100), contentMode: .fit)
        .frame(height: cardHeight)
        .cornerRadius(15)
        .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.17), radius: 10, x: -5, y: 10)
        
    }
}
