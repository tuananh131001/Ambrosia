//
//  RestaurantListView.swift
//  Ambrosia
//
//  Created by Võ Quốc Huy on 11/09/2022.
//

import SwiftUI



struct RestaurantListView: View {
    
    init (){
           // custom the ui navigation bar
           // custom large navigation title
           UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color("PrimaryColor")),.font : UIFont.systemFont(ofSize: 26)]
           // custom inline navigation title
           UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color("PrimaryColor")),.font : UIFont.systemFont(ofSize: 20)]
           // custom navigation background
           UINavigationBar.appearance().backgroundColor = UIColor.clear
           // custom navigation bar tint color
           UINavigationBar.appearance().barTintColor = UIColor(Color("ButtonTextColor"))
       }
    
    
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
                                    restaurantModel.fetchDetail(place_id: r.place_id)
                                    restaurantModel.currentRestaurant = r
                                }
                                
                            } label: {
                                // Card to show restaurant
                                RestaurantCardView(name: r.name, rating: r.rating ?? 5.0, status: r.opening_hours?.open_now ?? true, address: r.vicinity ?? "Sir city",photo_id: r.photos?[0].photo_reference ?? "testRestaurant",total_ratings: r.user_ratings_total ?? 1,distance: r.distance )
                            }
                        }
                    }.padding()
                    // add the search bar and set the mode to always display the search bar
                }.searchable(text: $searchText,placement:.navigationBarDrawer(displayMode: .always),prompt: "Search by restaurant's name")
                    .navigationTitle("Nearby Restaurants").accentColor(Color("PrimaryColor"))
            }
        }
        .onAppear {
//            restaurantModel.calculateDistanceRest()
        }
    }
    
    
}


struct RestaurantListView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantListView()
            .environmentObject(RestaurantModel())
    }
}

