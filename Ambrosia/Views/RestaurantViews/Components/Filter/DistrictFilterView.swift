//
//  DistrictFilterView.swift
//  Ambrosia
//
//  Created by William on 16/09/2022.
//

import SwiftUI

struct DistrictFilterView: View {
    @EnvironmentObject var model: RestaurantModel
    @State private var isDistrict5 = false
    @State private var isDistrict1 = false
    @State private var isDistrict2 = false
    @State private var isDistrict7 = false
    @State private var isDistrictGoVap = false
    @State private var filterRestaurant: [Restaurant] = [Restaurant]()
    var body: some View {
        VStack {
            HStack {
                Toggle("Quan 5", isOn: $isDistrict5)
                    .toggleStyle(.button)
                    .tint(.mint).onChange(of: isDistrict5) { value in
                    filterRestaurant = (value) ? model.restaurants.filter { $0.state == "District 5, Ho Chi Minh City" }: model.restaurants
                }
                Toggle("Quan 1", isOn: $isDistrict1)
                    .toggleStyle(.button)
                    .tint(.mint).onChange(of: isDistrict1) { value in
                    filterRestaurant = (value) ? model.restaurants.filter { $0.state == "District 1, Ho Chi Minh City" }: model.restaurants
                }
                Toggle("Quan 2", isOn: $isDistrict2)
                    .toggleStyle(.button)
                    .tint(.mint).onChange(of: isDistrict2) { value in
                    filterRestaurant = (value) ? model.restaurants.filter { $0.state == "District 2, Ho Chi Minh City" }: model.restaurants
                }
                Toggle("Quan 7", isOn: $isDistrict7)
                    .toggleStyle(.button)
                    .tint(.mint).onChange(of: isDistrict7) { value in
                    filterRestaurant = (value) ? model.restaurants.filter { $0.state == "District 7, Ho Chi Minh City" }: model.restaurants
                }
                Toggle("Quan Go Vap", isOn: $isDistrictGoVap)
                    .toggleStyle(.button)
                    .tint(.mint).onChange(of: isDistrictGoVap) { value in
                        print(isDistrictGoVap)
                        filterRestaurant = (value) ? model.restaurants.filter { $0.state == "Gò Vấp, Ho Chi Minh City" } : model.restaurants
                }

            }
            List(filterRestaurant, id: \.placeId) {
                res in
                Text(res.title ?? "")
            }
        }
    }

}

struct DistrictFilterView_Previews: PreviewProvider {
    static var previews: some View {
        DistrictFilterView()
    }
}
