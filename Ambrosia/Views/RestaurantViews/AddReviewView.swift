//
//  AddReview.swift
//  Ambrosia
//
//  Created by Võ Quốc Huy on 10/09/2022.
//

import SwiftUI


struct AddReviewView: View {
    var restaurant:Restaurant
    var review:Review
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var restaurantModel:RestaurantModel
    @State private var rating:Int = 0
    @State private var userReview = ""
    
    var body: some View {
        GeometryReader{
            geo in
            VStack(alignment:.leading,spacing:20){
                VStack(spacing:10){
                    Image(restaurant.photos?[0].photo_reference ?? "testRestaurant").resizable().aspectRatio(contentMode: .fill).frame(width:geo.size.width,height: geo.size.height/3).ignoresSafeArea()
                    Text(restaurant.name).foregroundColor(Color("TextColor"))
                    Text(restaurant.formatted_address ?? "").foregroundColor(Color("SubTextColor"))
                }
                
                VStack(alignment:.leading,spacing:20){
                    Text("Rate restaurant").foregroundColor(Color("TextColor")).bold()
                    RatingView(rating: $rating, tappable: true, width: 25, height: 20)
                    
                }.padding()
                VStack(alignment:.leading){
                    Text("Leave a review").foregroundColor(Color("TextColor")).bold()
                    TextEditor(text: $userReview)
                        .foregroundColor(Color("TextColor")).frame(minWidth: 0, maxWidth: geo.size.width, minHeight: 0, maxHeight: 150)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("PrimaryColor"), lineWidth: 1)
                        )
                        .lineSpacing(10.0)
                        .disableAutocorrection(true)
                    
                }.padding(.horizontal)
                Button {
                    presentationMode.wrappedValue.dismiss()
                    // Add Review from user
                    //TODO: Load restaurant from restaurant models
                    //                    restaurantModel.addReviewFromUser(reviewDescription: userReview, rating: rating, name: User.testUser().username, email: User.testUser().email, image: User.testUser().image)
                } label: {
                    RoundedButton(buttonText: "Submit", width: geo.size.width/1.1, height: 60)
                }.padding(.horizontal)
                
            }
        }
    }
}

struct AddReview_Previews: PreviewProvider {
    static var previews: some View {
        AddReviewView(restaurant: Restaurant.testRestaurant(),review:Review.testReviews()[1])
    }
}
