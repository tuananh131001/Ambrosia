//
//  RestaurantList.swift
//  Ambrosia
//
//  Created by Nhung Tran on 09/09/2022.
//

import SwiftUI

struct RestaurantList: View {
    @EnvironmentObject var restaurantModel: RestaurantModel
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Popular")
                .font(.title)
                .bold()
                .padding(.horizontal)
            // MARK: display list of popular restaurants horizontally
            ScrollView{
                VStack{
                    ForEach(restaurantModel.restaurants,id:\.place_id){ res in
                        RestaurantCard(rest: res, cardWidth: UIScreen.main.bounds.width - 30, cardHeight: 357, displayType: "all")
                    }
                }
            }
        }
        .onAppear {
            restaurantModel.addReviewFromUser(reviewDescription: "như Sir", rating: 10,username: "Sir",email: "Sir@gmail.com")
            print(restaurantModel.restaurants[0].review)
        }
    }
}

struct RestaurantList_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantList()
    }
}
