//
//  RestaurantListView.swift
//  Ambrosia
//
//  Created by Võ Quốc Huy on 11/09/2022.
//

import SwiftUI



struct RestaurantListView: View {
    @EnvironmentObject var restaurantModel: RestaurantModel
    // State variable  to track the user input
    @State private var searchText = ""
    // function to return the restaurants array by the user input
    var searchResults: [Restaurant] {
        // if the search bar is empty -> show all
        if searchText.isEmpty {
            return restaurantModel.restaurants
        } else {
            // search items that contain either title or address (Case insensitive) from user input
            return restaurantModel.restaurants.filter { $0.name.localizedCaseInsensitiveContains(searchText)
                
            }
        }
    }
    var body: some View {
        NavigationView {
            VStack {
                // scroll view to show all the restaurants
                ScrollView(showsIndicators: false){
                    LazyVStack(spacing:35) {
                        ForEach(searchResults,id: \.place_id){
                            r in
                            // link to the restaurant detail
                            NavigationLink {
                                // find the current restaurant and display when the view appear
                                RestaurantDetailView().onAppear {
                                    restaurantModel.getCurrentRestaurant(id: r.place_id)
                                }
                                
                            } label: {
                                // Card to show restaurant
                                RestaurantCardView(name: r.name, rating: r.rating ?? 5.0, status: r.opening_hours?.open_now ?? true, address: r.vicinity ?? "Sir city",photo_id: r.photos?[0].photo_reference ?? "testRestaurant",total_ratings: r.user_ratings_total ?? 1)
                            }
                        }
                    }
                    // add the search bar and set the mode to always display the search bar
                }.navigationTitle("Restaurants").accentColor(.black).searchable(text: $searchText,placement:.navigationBarDrawer(displayMode: .always),prompt: "Search by restaurant's name")
            }
        }.padding()
    }
    
    
}


struct RestaurantListView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantListView()
            .environmentObject(RestaurantModel())
    }
}

