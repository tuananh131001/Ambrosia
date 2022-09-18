/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 3
 Author: Vo Quoc Huy
 ID: s3823236
 Created  date: 17/09/2022
 Last modified: 17/09/2022
 Acknowledgement:
 - Canvas
 */


import SwiftUI

struct VerticalListView: View {
    // MARK: display restaurant list view vertically
    
    @EnvironmentObject var restaurantModel:RestaurantModel
    @State private var searchText = ""
    var type:String
    
    // MARK: storing searching results to restaurant
    var searchResults: [Restaurant] {
        // if the search bar is empty -> show all
        if searchText.isEmpty {
            return type == "all" ? restaurantModel.restaurants : restaurantModel.districtRestaurants
            
            
        } else {
            return type == "all" ? restaurantModel.restaurants.filter { $0.title.localizedCaseInsensitiveContains(searchText)
            } : restaurantModel.districtRestaurants.filter { $0.title.localizedCaseInsensitiveContains(searchText)
            }
        }
        
    }
    var body: some View {
        ScrollView(showsIndicators: false) {
            
            LazyVStack(spacing: 35) {
                ForEach(0..<searchResults.count, id: \.self) {
                    index in
                    // link to the restaurant detail
                    NavigationLink() {
                        // find the current restaurant and display when the view appear
                        RestaurantDetailView().onAppear {
                            if (type == "all") {
                                restaurantModel.getCurrentRestaurant(placeId: searchResults[index].placeId ?? "")
                                
                            }else {
                                restaurantModel.getCurrentRestaurantByDistance(placeId: searchResults[index].placeId ?? "")
                                
                            }
                            
                            // after: get that restaurant's complex details
                            restaurantModel.getServiceOptions()
                            restaurantModel.getDiningOptions()
                            restaurantModel.getPlaningOptions()
                            restaurantModel.getPaymentOptions()
                        }
                        
                    } label: {
                        // MARK: Card to show restaurant
                        RestaurantCardView(name: searchResults[index].title, rating: searchResults[index].totalScore ?? 5.0, address: searchResults[index].address ?? "", photo_id: searchResults[index].imageLink , total_ratings: searchResults[index].rank ?? 1, distance: searchResults[index].distance)
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        // on click/ tap -> sound effect
                        SoundModel.clickCardSound()
                    })
                    
                }
            }.padding()
            
        }.searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search by restaurant's name").disableAutocorrection(true)
        
        
        // add the search bar and set the mode to always display the search bar
    }
    
    
}

struct VerticalListView_Previews: PreviewProvider {
    static var previews: some View {
        VerticalListView(type: "all")
    }
}
