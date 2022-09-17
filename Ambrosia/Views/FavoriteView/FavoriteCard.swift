//
//  FavoriteCard.swift
//  Ambrosia
//
//  Created by Nhung Tran on 17/09/2022.
//

import SwiftUI

struct FavoriteCard: View {
    @EnvironmentObject var restaurantModel: RestaurantModel
    var imageSize: CGFloat
    var cardHeight: CGFloat
    var geo: GeometryProxy
    
    var rest: Restaurant
    var body: some View {
        VStack(spacing: 5) {
            NavigationLink(
                tag: restaurantModel.findRestaurantIndexById(rest.placeId ?? ""),
                selection: $restaurantModel.restaurantSelected) {
                // find the current restaurant and display when the view appear
                RestaurantDetailView().onAppear {
                    // MARK: action
                    restaurantModel.getCurrentRestaurant(placeId: rest.placeId ?? "")
                    restaurantModel.getServiceOptions()
                    restaurantModel.getDiningOptions()
                    restaurantModel.getPlaningOptions()
                    restaurantModel.getPaymentOptions()
                }
            } label: {
                // MARK: view
                FavoriteContent(imageSize: imageSize, rest: rest)
                    .frame(width: geo.size.width * 0.8, height: cardHeight, alignment: .leading)

            }
                .edgesIgnoringSafeArea(.horizontal)
            Divider()
        }
    }
}
