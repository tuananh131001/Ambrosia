/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 3
 Author: Tran Mai Nhung
 ID: s3879954
 Created  date: 17/09/2022
 Last modified: 17/09/2022
 Acknowledgement:
 - Canvas
 - https://onmyway133.com/posts/how-to-use-foreach-with-indices-in-swiftui/
 - https://swiftbysundell.com/articles/stroking-and-filling-a-swiftui-shape-at-the-same-time
 */

import SwiftUI

struct FavoriteCard: View {
    // label and navigation link
    
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
                        // current rest
                        restaurantModel.getCurrentRestaurant(placeId: rest.placeId ?? "")
                        
                        // from that -> get rest details
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
                .simultaneousGesture(TapGesture().onEnded {
                    // add sound on tap
                    SoundModel.clickCardSound()
                })
            Divider()
        }
    }
}
