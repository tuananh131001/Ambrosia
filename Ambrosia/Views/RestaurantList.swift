//
//  RestaurantList.swift
//  Ambrosia
//
//  Created by Nhung Tran on 09/09/2022.
//

import SwiftUI

struct RestaurantList: View {
    @EnvironmentObject var model: RestaurantModel
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Popular")
                .font(.title)
                .bold()
                .padding(.horizontal)
            // MARK: display list of popular restaurants horizontally
//            NavigationView {
//                ScrollView(.horizontal, showsIndicators: false) {
//                    VStack(spacing: 10) {
//                        ForEach(model.restaurants, id: \.place_id) { res in
//                            // check if restaurant is popular -> display
//                            NavigationLink(destination: RestaurantDetailView(rest: res)) {
//                                Text("Restaurant name " + res.name)
//                            }
//                        }
//
//                    }
//                }
//            }
            List(model.restaurants,id:\.place_id){ res in
                Text(res.name)
            }
        }.onAppear(perform: model.fetchRestaurant)
    }
}

struct RestaurantList_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantList()
    }
}
