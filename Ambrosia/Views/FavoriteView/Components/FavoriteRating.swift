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
    @EnvironmentObject var userModel: UserModel
    @StateObject var firebaseService = FirebaseService.services

    var body: some View {
        HStack {
            let totalScore = restaurant.totalScore ?? 5.0
            Text("\(totalScore, specifier: "%.1f")")
                .foregroundColor(Constants.SECONDARY_COLOR)
                .bold()
            HStack(spacing: 1) {
                ForEach(0..<5) { index in
                    Image(systemName: "star.fill")
                        .foregroundColor(Color("Star \(index < Int(totalScore) ? "On" : "Off") Color"))
                }
            }

            Spacer()

        }
        .font(.subheadline)
    }
}
