//
//  FavoriteComponent.swift
//  Ambrosia
//
//  Created by Nhung Tran on 16/09/2022.
//

import SwiftUI

struct FavoriteRating: View {
//    var rating: Double?
    var restaurant: Restaurant
    var starSize: CGFloat
    var titleSize: CGFloat
    
    @EnvironmentObject var userModel: UserModel
    @StateObject var firebaseService = FirebaseService.services

    var body: some View {
        HStack {
            let totalScore = restaurant.totalScore ?? 5.0
            Text("\(totalScore, specifier: "%.1f")")
                .font(.system(size: starSize + 4))
                .foregroundColor(Color("SubTextColor"))
            HStack {
                ForEach(0..<5) { index in
                    ImageSystemHier(name: "star.fill", color: "Star \(index <= Int(totalScore) ? "On" : "Off") Color", size: starSize)
                }
            }

            Spacer()

        }
    }
}
