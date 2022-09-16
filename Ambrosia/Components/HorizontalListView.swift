//
//  HorizontalListView.swift
//  Ambrosia
//
//  Created by Võ Quốc Huy on 16/09/2022.
//

import SwiftUI

struct HorizontalListView: View {
    @EnvironmentObject var restaurantModel: RestaurantModel
    var sectionTitle:String
 
    
    var body: some View {
        VStack(alignment:.leading){
            Text(sectionTitle).bold().foregroundColor(Color("TextColor"))
                ScrollView(.horizontal,showsIndicators: false){
                    
                    LazyHStack() {
                        ForEach(0..<restaurantModel.sortedByRankRestaurants.count,id:\.self){
                            index in
                            NavigationLink(destination: {
                                RestaurantDetailView().onAppear {
                                    restaurantModel.getCurrentRestaurant(placeId: restaurantModel.sortedByRankRestaurants[index].placeId ?? "")
                                    restaurantModel.getServiceOptions()
                                    restaurantModel.getDiningOptions()
                                    restaurantModel.getPlaningOptions()
                                    restaurantModel.getPaymentOptions()
                                }
                            }, label: {
                                HorizontalRestaurantCard(restaurantName: restaurantModel.sortedByRankRestaurants[index].title , rating: restaurantModel.sortedByRankRestaurants[index].totalScore ?? 0.2, ratingCount: restaurantModel.sortedByRankRestaurants[index].reviewsCount ?? 2)
                            }
                          )
                        }
                    }
                }
            
       
        }.frame(height: 250).padding()
    }
}

struct HorizontalListView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalListView(sectionTitle:"Suggested Restaurants").environmentObject(RestaurantModel())
    }
}
