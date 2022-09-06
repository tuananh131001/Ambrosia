/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Tran Mai Nhung
 ID: s3879954
 Created  date: 29/07/2022
 Last modified: 07/08/2022
 Acknowledgement:
 - Canvas, CodeWithChris Course
 */

import SwiftUI

struct FoodListView: View {
    @EnvironmentObject var model: RestaurantModel
    // check if food detail view is open and showed
    @State var isFoodDetailShowing = false
    var rest: Restaurant
    var body: some View {
        LazyVStack(alignment: .leading) {
            // list of categories from food -> display food based on categories
            let categories = model.findAllCategories(rest.id)
            ForEach(categories.indices, id: \.self) { index in
                // MARK: category name
                // display text in custom shape (arrow shape)
                Text(categories[index] == "" ? "DISHES" : categories[index].uppercased())
                    .bold()
                    .foregroundColor(.white)
                    .font(.title2)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding()
                    .multilineTextAlignment(.center)
                    .background(ArrowShape()
                        .fill(Color("CategoryTitleBckColor"))
                        .shadow(radius: 10))
                    .padding(.top, index == 0 ? 30 : 40)
                
                
                // MARK: food display following its category
                LazyVStack(alignment: .leading, spacing: 20) {
                    ForEach(rest.foodList) { food in
                        if (food.category == categories[index]) {
                            Button(action: {
                                if (food.description != "") {
                                    // only display if food is not drink (drink have nothing to show in details)
                                    self.isFoodDetailShowing = true
                                }
                                model.navigateFood(food.id, rest.id)
                            }, label: {
                                // Display food as card for each food
                                FoodCardView(food: food, rest: rest)
                            })
                            .sheet(isPresented: $isFoodDetailShowing, content: { // display food detail when clicking button
                                FoodDetailView(food: model.currentFood ?? Food(), rest: rest, isFoodDetailShowing: $isFoodDetailShowing)
                            })
                            // for user style not button auto style
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .padding()
                
            }
            
        }
    }
}
