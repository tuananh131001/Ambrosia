//
//  FavoriteComponent.swift
//  Ambrosia
//
//  Created by Nhung Tran on 16/09/2022.
//

import SwiftUI

struct FavoriteRating: View {
//    var rating: Double?
//    var restaurant: Restaurant
    var index: Int
    var starSize: CGFloat
    var titleSize: CGFloat
    
    @EnvironmentObject var userModel: UserModel
    @StateObject var firebaseService = FirebaseService.services

    var body: some View {
        HStack {
            Text("\(userModel.user.favouriteRestaurants[index].totalScore ?? 5.0, specifier: "%.1f")")
                .font(.system(size: starSize + 4))
                .foregroundColor(Color("Fv Special Clr 2"))
            ImageSystemHier(name: "star.fill", color: "Star On Color", size: starSize)

            Spacer()
            
            Button {
                print("sir index \(index)")
                userModel.user.favouriteRestaurants[index].isFavorite = firebaseService.changeFavorites(userModel: userModel, restaurant: userModel.user.favouriteRestaurants[index])
                
            } label: {
                ImageSystemHier(name: "heart\(userModel.user.favouriteRestaurants[index].isFavorite ? ".fill" : "")", color: "Close Color", size: titleSize)
            }

        }
    }
}
