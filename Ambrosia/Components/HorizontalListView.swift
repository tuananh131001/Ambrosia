/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 3
 Author: Vo Quoc Huy
 ID: s3823236
 Created  date: 16/09/2022
 Last modified: 17/09/2022
 Acknowledgement:
 - Canvas
 */

import SwiftUI

struct HorizontalListView: View {
    // MARK: display restaurant list view horizontally
    
    @EnvironmentObject var restaurantModel: RestaurantModel
    var sectionTitle:String
    var type:String
    
    var body: some View {
        VStack(alignment:.leading){
            // MARK: name of list view
            Text(sectionTitle).bold().foregroundColor(Color("TextColor"))
            // scroll
            ScrollView(.horizontal,showsIndicators: false){
                
                LazyHStack() {
                    // MARK: - suggestion section (highest ranking scores)
                    if (type == "suggestion"){
                        ForEach(0..<restaurantModel.sortedByRankRestaurants.count,id:\.self){
                            index in
                            NavigationLink(destination: {
                                RestaurantDetailView().onAppear {
                                    // MARK: action
                                    // get current restaurant first
                                    restaurantModel.getCurrentRestaurant(placeId: restaurantModel.sortedByRankRestaurants[index].placeId ?? "")
                                    
                                    // from that -> get restaurant complex details
                                    restaurantModel.getServiceOptions()
                                    restaurantModel.getDiningOptions()
                                    restaurantModel.getPlaningOptions()
                                    restaurantModel.getPaymentOptions()
                                }
                            }, label: {
                                // MARK: style the card (with display based on result sorted by rank)
                                HorizontalRestaurantCard(restaurantName: restaurantModel.sortedByRankRestaurants[index].title , rating: restaurantModel.sortedByRankRestaurants[index].totalScore ?? 0.2, ratingCount: restaurantModel.sortedByRankRestaurants[index].reviewsCount ?? 5,distance: restaurantModel.sortedByRankRestaurants[index].distance,imageLink: restaurantModel.sortedByRankRestaurants[index].imageLink)
                            }
                            )
                            .simultaneousGesture(TapGesture().onEnded {
                                // add sound if tapping
                                SoundModel.clickCardSound()
                            })
                        }
                    }
                    // MARK: - nearby section
                    else if (type == "nearby"){
                        ForEach(0..<restaurantModel.sortedByDistanceRestaurants.count,id:\.self){
                            index in
                            NavigationLink(destination: {
                                RestaurantDetailView().onAppear {
                                    // MARK: action
                                    // get current restaurant
                                    restaurantModel.getCurrentRestaurant(placeId: restaurantModel.sortedByDistanceRestaurants[index].placeId ?? "")
                                    
                                    // from that -> get restaurant complex details
                                    restaurantModel.getServiceOptions()
                                    restaurantModel.getDiningOptions()
                                    restaurantModel.getPlaningOptions()
                                    restaurantModel.getPaymentOptions()
                                }
                            }, label: {
                                // MARK: style restaurant card (with display based on result sorted by distance)
                                HorizontalRestaurantCard(restaurantName: restaurantModel.sortedByDistanceRestaurants[index].title , rating: restaurantModel.sortedByDistanceRestaurants[index].totalScore ?? 0.2, ratingCount: restaurantModel.sortedByDistanceRestaurants[index].reviewsCount ?? 5,distance: restaurantModel.sortedByDistanceRestaurants[index].distance,imageLink: restaurantModel.sortedByDistanceRestaurants[index].imageLink)
                            }
                            )
                            .simultaneousGesture(TapGesture().onEnded {
                                // add sound if tapping
                                SoundModel.clickCardSound()
                            })
                        }
                    }
                    
                }
            }
            
            
        }.frame(height: 250).padding()
    }
}

struct HorizontalListView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalListView(sectionTitle:"Suggested Restaurants",type: "suggestion").environmentObject(RestaurantModel())
    }
}
