/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 3
 Author: Nguyen Tuan Anh, Vo Quoc Huy
 ID: s3864077, s3823236
 Created  date: 10/09/2022
 Last modified: 17/09/2022
 Acknowledgement:
 - Canvas
 */

import SwiftUI

struct RestaurantAsyncImage: View {
    var photo_id:String
    var cardWidth: CGFloat = UIScreen.main.bounds.width - 30
    var cardHeight: CGFloat = 357
    var displayType: String = "all"
    
    var body: some View {
        ZStack {
            // Image of each map
            //            AsyncImage(url: URL(string: "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=\(photo_id)&key=AIzaSyC2jWBSaP5fZLAuwlOc2mwcSBHfYXtv6hU")) { image in
            //            AsyncImage(url: URL(string: "https://unsplash.com/s/photos/restaurant-food")) { image in
            
            // Image
            AsyncImage(url: URL(string: "\(photo_id)")) { image in
                image.renderingMode(.original)
                image.resizable()
                image.aspectRatio(contentMode: .fit)
                image.ignoresSafeArea()
            } placeholder: {
                Image("random-eat").resizable().aspectRatio(contentMode:
                        .fill).frame(width: 150, height: 150).cornerRadius(10)
            }
            // shadow for editting image look
            ImageShadowView()
        }
        
    }
}

