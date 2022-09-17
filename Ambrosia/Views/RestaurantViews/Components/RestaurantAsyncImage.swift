//
//  RestaurantAsyncImage.swift
//  Ambrosia
//
//  Created by William on 10/09/2022.
//

import SwiftUI

struct RestaurantAsyncImage: View {
    var photo_id: String
    var cardWidth: CGFloat = UIScreen.main.bounds.width - 30
    var cardHeight: CGFloat = 357
    var displayType: String = "all"
    
    var body: some View {
        ZStack {
            // Image of each map
//            AsyncImage(url: URL(string: "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=\(photo_id)&key=AIzaSyC2jWBSaP5fZLAuwlOc2mwcSBHfYXtv6hU")) { image in
//            AsyncImage(url: URL(string: "https://unsplash.com/s/photos/restaurant-food")) { image in
            AsyncImage(url: URL(string: "\(photo_id)")) { image in
                image.renderingMode(.original)
                image.resizable()
                image.aspectRatio(contentMode: .fit)
                image.ignoresSafeArea()
            } placeholder: {
                Image("testRestaurant")
            }
            ImageShadowView()
        }.onAppear(perform: {
            print("name \(photo_id)")
        })

    }
}

