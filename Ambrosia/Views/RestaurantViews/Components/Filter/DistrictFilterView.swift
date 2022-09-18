/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 3
 Author: Nguyen Tuan Anh, Vo Quoc Huy
 ID: s3864077, s3823236
 Created  date: 16/09/2022
 Last modified: 17/09/2022
 Acknowledgement:
 - Canvas
 */

import SwiftUI

struct DistrictFilterView: View {
    @EnvironmentObject var restaurantModel: RestaurantModel
    @State private var isDistrict5 = false
    @State private var isDistrict1 = false
    @State private var isDistrict2 = false
    @State private var isDistrict7 = false
    @State private var isDistrictGoVap = false
    
    @State private var filterRestaurant: [Restaurant] = [Restaurant]()
    
    var body: some View {
        VStack (alignment:.leading){
            // MARK: - Title
            Text("Find restaurants by district").bold().foregroundColor(Color("TextColor"))
            
            // MARK: - Content
            ScrollView(.horizontal,showsIndicators: false) {
                LazyHStack {
                    // MARK: District 1
                    // every click -> navigate to list of rests in that district
                    NavigationLink {
                        VerticalListView(type: "district").onAppear{
                            restaurantModel.filterRestaurantByDistrict(district: "District 1")
                        }                    } label: {
                            RoundedButton(buttonText: "🍝   District 1", width: 120, height: 35,size: 12)
                        }
                    
                    // MARK: District 2
                    NavigationLink {
                        VerticalListView(type: "district").onAppear{
                            restaurantModel.filterRestaurantByDistrict(district: "District 2")
                        }                    } label: {
                            RoundedButton(buttonText: "🍺   District 2", width: 120, height: 35,size: 12)
                        }
                    
                    // MARK: District 5
                    NavigationLink {
                        VerticalListView(type: "district").onAppear{
                            restaurantModel.filterRestaurantByDistrict(district: "District 5")
                        }                    } label: {
                            RoundedButton(buttonText: "🍜   District 5", width: 120, height: 35,size: 12)
                        }
                    
                    // MARK: District 7
                    NavigationLink {
                        VerticalListView(type: "district").onAppear{
                            restaurantModel.filterRestaurantByDistrict(district: "District 7")
                        }                    } label: {
                            RoundedButton(buttonText: "🍧   District 7", width: 120, height: 35,size: 12)
                        }
                    
                    // MARK: District Go Vap
                    NavigationLink {
                        VerticalListView(type: "district").onAppear{
                            restaurantModel.filterRestaurantByDistrict(district: "Gò Vấp")
                        }
                    } label: {
                        RoundedButton(buttonText: "🍙   Go Vap", width: 120, height: 35,size: 12)
                    }
                    
                    
                    
                }
                .simultaneousGesture(TapGesture().onEnded {
                    SoundModel.clickButtonSound()
                })
                
            }
        }.padding()
    }
}
