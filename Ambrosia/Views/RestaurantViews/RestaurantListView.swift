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
        NavigationView {
            
            ScrollView {
                HStack{
                    DistrictFilterView()
                }
                HorizontalListView(sectionTitle: "Suggestion Restaurants", type: "suggestion")
                HorizontalListView(sectionTitle: "Nearby Restaurants", type: "nearby")
                VStack (alignment: .leading) {
                    Text("All Restaurants").bold().foregroundColor(Color("TextColor"))
                    // scroll view to show all the restaurants
                    ScrollView(showsIndicators: false) {
                        
                        LazyVStack(alignment:.trailing,spacing: 35) {
                            ForEach(0..<restaurantModel.firstTwentyRestaurants.count, id: \.self) {
                                index in
                                // link to the restaurant detail
                                NavigationLink() {
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
                                        RestaurantCardView(name: restaurantModel.firstTwentyRestaurants[index].title, rating: restaurantModel.firstTwentyRestaurants[index].totalScore ?? 5.0, address: restaurantModel.firstTwentyRestaurants[index].address ?? "", photo_id: restaurantModel.firstTwentyRestaurants[index].imageLink ?? "", total_ratings: restaurantModel.firstTwentyRestaurants[index].rank ?? 1, distance: restaurantModel.firstTwentyRestaurants[index].distance)
                                    }
                                    .simultaneousGesture(TapGesture().onEnded {
                                        SoundModel.clickCardSound()
                                    })
                                
                            }
                            NavigationLink {
                                VerticalListView(type: "all")
                            } label: {
                                Text("See More").foregroundColor(Color("SecondaryColor")).font(.system(size: 16)).offset(y:-20)
                            }

                        }
                        
                    }
                    
                    
                    // add the search bar and set the mode to always display the search bar
                }.navigationTitle("Ambrosia").accentColor(Color("PrimaryColor")).padding()
                
            } .onChange(of: restaurantModel.restaurantSelected) { newValue in
                if (newValue ==
                    nil) {
                    restaurantModel.currentRestaurant = nil
                }
            }
            .background(Constants.BCK_COLOR)
        }.navigationViewStyle(StackNavigationViewStyle())
        
    }
}


struct RestaurantListView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantListView()
            .environmentObject(RestaurantModel())
    }
}
