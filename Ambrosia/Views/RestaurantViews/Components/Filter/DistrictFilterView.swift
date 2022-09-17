//
//  DistrictFilterView.swift
//  Ambrosia
//
//  Created by William on 16/09/2022.
//

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
            Text("Find restaurants by district").bold().foregroundColor(Color("TextColor"))
           
            ScrollView(.horizontal,showsIndicators: false) {
                LazyHStack {
                    NavigationLink {
                        VerticalListView(type: "district").onAppear{
                            restaurantModel.filterRestaurantByDistrict(district: "District 1")
                        }                    } label: {
                        RoundedButton(buttonText: "🍝   District 1", width: 120, height: 35)
                    }

                
                    NavigationLink {
                        VerticalListView(type: "district").onAppear{
                            restaurantModel.filterRestaurantByDistrict(district: "District 2")
                        }                    } label: {
                        RoundedButton(buttonText: "🍺   District 2", width: 120, height: 35)
                    }
                    
                    NavigationLink {
                        VerticalListView(type: "district").onAppear{
                            restaurantModel.filterRestaurantByDistrict(district: "District 5")
                        }                    } label: {
                        RoundedButton(buttonText: "🍜   District 5", width: 120, height: 35)
                    }
                    
                    NavigationLink {
                        VerticalListView(type: "district").onAppear{
                            restaurantModel.filterRestaurantByDistrict(district: "District 7")
                        }                    } label: {
                        RoundedButton(buttonText: "🍧   District 7", width: 120, height: 35)
                    }
                    
                    NavigationLink {
                        VerticalListView(type: "district").onAppear{
                            restaurantModel.filterRestaurantByDistrict(district: "Gò Vấp")
                        }
                    } label: {
                        RoundedButton(buttonText: "🍙   Go Vap", width: 120, height: 35)
                    }
                    
                   
                   
                }

        }
        }.padding()
    }
}
