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

struct PopularRestaurantsView: View {
    @EnvironmentObject var model: RestaurantModel
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Popular")
                .font(.title)
                .bold()
                .padding(.horizontal)
            
            // MARK: display list of popular restaurants horizontally
            if (model.hasPopularRestaurant()) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(model.restaurants.indices, id: \.self) { index in
                            // check if restaurant is popular -> display
                            if (model.restaurants[index].isPopular()) {
                                NavigateLink(
                                    destinationView: AnyView(RestaurantDetailView(rest: model.restaurants[index])),
                                    labelView: AnyView(RestaurantCardView(rest: model.restaurants[index], cardWidth: 250, cardHeight: 180, displayType: "popular")),
                                    navigateMethod: {model.navigateRestaurant(model.restaurants[index].id)})
                                .padding()
                                if (index != model.restaurants.count - 1) {
                                    Divider()
                                }
                            }
                        }
                    }
                }
            }
            else {
                // Display if no popular restaurant
                NotFoundView(message: "No Popular Restaurants Now")
            }
        }
        
    }
}
