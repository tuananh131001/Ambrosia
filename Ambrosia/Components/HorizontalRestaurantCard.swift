//
//  HorizontalRestaurantCard.swift
//  Ambrosia
//
//  Created by Võ Quốc Huy on 16/09/2022.
//

import SwiftUI

struct HorizontalRestaurantCard: View {
    var restaurantName: String
    var rating: Double
    var ratingCount: Int
    var distance: Double
    var imageLink: String
    var body: some View {
        
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: "\(imageLink)")) { image in
                image.frame(width: 150, height: 150)
                    .background(Color.gray)
                    .cornerRadius(10)
            } placeholder: {
                Image("random-eat").resizable().aspectRatio(contentMode:
                        .fill).frame(width: 150, height: 150).cornerRadius(10)
            }
            
            HStack {
                Image(systemName: "checkmark.seal.fill").foregroundColor(Color("SecondaryColor")).frame(width: 14, height: 14)
                Text(restaurantName).foregroundColor(Color("TextColor")).font(.system(size: 14)).lineLimit(1)
            }.frame(width: 150)
            HStack {
                Text("⭐️").font(.system(size: 14))
                Text("\(rating, specifier: "%.1f")").foregroundColor(Color("SubTextColor")).font(.system(size: 14))
                Text("(\(ratingCount))").foregroundColor(Color("SubTextColor")).font(.system(size: 12)).offset(x: -5)
                Spacer()
                Text("🚗\(distance, specifier: "%.1f") km").foregroundColor(Color("SubTextColor")).font(.system(size: 14))
                
            }
        }.padding(.leading, 10)
    }
}

struct HorizontalRestaurantCard_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalRestaurantCard(restaurantName: "Hải Sản Hoàng Gia", rating: 4.5, ratingCount: 320, distance: 2.0, imageLink: "")
    }
}
