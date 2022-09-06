/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Tran Mai Nhung
 ID: s3879954
 Created  date: 29/07/2022
 Last modified: 07/08/2022
 Acknowledgement: Canvas, CodeWithChris Course
 */

import SwiftUI

struct FoodDetailView: View {
    var food: Food
    var rest: Restaurant
    @Binding var isFoodDetailShowing: Bool
    @EnvironmentObject var model: RestaurantModel
    var body: some View {
        // MARK: food information
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                ZStack {
                    // MARK: image
                    ZStack {
                        Image("\(rest.name)-\(food.name)")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        ImageShadowView(opacity: 0.6)
                    }
                    .frame(width: UIScreen.main.bounds.width)
                    .clipped()
                    // MARK: close button
                    Button(action: {
                        isFoodDetailShowing.toggle()
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.white, Color("CloseXBckColor").opacity(0.5))
                            .font(.system(size: 40))
                            .position(x: 30, y: 30)
                    })
                    
                }
                
                HStack(alignment: .center) {
                    // MARK: food name
                    Text(food.name)
                        .font(.title)
                        .bold()
                        .foregroundColor(Color("RestDetailTitleColor"))
                        .lineSpacing(1)
                        .padding(.horizontal)
                    Spacer()
                    
                    // MARK: Price
                    Text("\(food.price) VND")
                        .font(.headline)
                        .foregroundColor(Color("FoodCardDescriptionColor"))
                        .padding(.horizontal)
                }
                
                
                VStack(alignment: .leading, spacing: 3) {
                    // MARK: Description
                    IngredientsView(descArr: UltilityModel.splitStringComma(food.description))
                    
                    
                }
                .padding(.horizontal)
                
                Spacer()
                // MARK: ending page image
                Image("page-divider")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 10)
                    .opacity(0.3)
                    .contrast(-0.13)
                Spacer()
                
                
                
            }
            .frame(minHeight: 110)
            .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.17), radius: 10, x: -5, y: 10)
            .onAppear {
                model.navigateFood(food.id, rest.id)
            }
            
        }
        
    }
}
