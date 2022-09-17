//
//  RestaurantListView.swift
//  Ambrosia
//
//  Created by Võ Quốc Huy on 11/09/2022.
//

import SwiftUI



struct RestaurantListView: View {
    
    init () {
        // custom the ui navigation bar
        // custom large navigation title
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color("PrimaryColor")), .font: UIFont.systemFont(ofSize: 26)]
        // custom inline navigation title
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color("PrimaryColor")), .font: UIFont.systemFont(ofSize: 20)]
        // custom navigation background
        UINavigationBar.appearance().backgroundColor = UIColor.clear
        // custom navigation bar tint color
        UINavigationBar.appearance().barTintColor = UIColor(Color("ButtonTextColor"))
    }
    
    
    @EnvironmentObject var restaurantModel: RestaurantModel
    // State variable  to track the user input
    @State private var searchText = ""
    @State private var isTapped: Bool = false
    // function to return the restaurants array by the user input

    var body: some View {
        if restaurantModel.restaurants.count != 0 {
            NavigationView {
                ScrollView {
                    HorizontalListView(sectionTitle: "Suggestion Restaurants", type: "suggestion")
                    HorizontalListView(sectionTitle: "Nearby Restaurants", type: "nearby")
                    VStack (alignment: .leading) {
                        Text("All Restaurants").bold().foregroundColor(Color("TextColor"))
                        // scroll view to show all the restaurants
                        ScrollView(showsIndicators: false) {

                            LazyVStack(spacing: 35) {
                                ForEach(0..<restaurantModel.firstTwentyRestaurants.count, id: \.self) {
                                    index in
                                    // link to the restaurant detail
                                    NavigationLink(
                                        tag: index,
                                        selection: $restaurantModel.restaurantSelected) {
                                        // find the current restaurant and display when the view appear
                                        RestaurantDetailView().onAppear {
                                            restaurantModel.getCurrentRestaurant(placeId: restaurantModel.firstTwentyRestaurants[index].placeId ?? "")
                                            restaurantModel.getServiceOptions()
                                            restaurantModel.getDiningOptions()
                                            restaurantModel.getPlaningOptions()
                                            restaurantModel.getPaymentOptions()
                                        }

                                    } label: {
                                        // Card to show restaurant
                                        RestaurantCardView(name: restaurantModel.firstTwentyRestaurants[index].title, rating: restaurantModel.firstTwentyRestaurants[index].totalScore ?? 5.0, address: restaurantModel.firstTwentyRestaurants[index].address ?? "", photo_id: restaurantModel.firstTwentyRestaurants[index].imageLink , total_ratings: restaurantModel.firstTwentyRestaurants[index].rank ?? 1, distance: restaurantModel.firstTwentyRestaurants[index].distance)
                                    }
                                        .simultaneousGesture(TapGesture().onEnded {
                                            SoundModel.clickCardSound()
                                        })

                                }
                            }

                        }


                        // add the search bar and set the mode to always display the search bar
                    }.searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search by restaurant's name").navigationTitle("Ambrosia").accentColor(Color("PrimaryColor")).padding()

                } .onChange(of: restaurantModel.restaurantSelected) { newValue in
                    if (newValue ==
                            nil) {
                        restaurantModel.currentRestaurant = nil
                    }
                }
                    .background(Constants.BCK_COLOR)
                    .onChange(of: restaurantModel.restaurantSelected) { newValue in
                    if (newValue ==
                            nil) {
                        restaurantModel.currentRestaurant = nil
                    }
                }.navigationViewStyle(StackNavigationViewStyle())
                    .onChange(of: restaurantModel.currentRestaurant?.reviews.count) { newValue in
                }
            }

        }
        else{
            ProgressView()
//            ProgressView() {
//                VStack {
//                    GifView(name: "nothing").offset(y: 120)
//                }
//            }
//                .progressViewStyle(CircularProgressViewStyle(tint: Color("PrimaryColor")))
        }
    }
}


struct RestaurantListView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantListView()
            .environmentObject(RestaurantModel())
    }
}

