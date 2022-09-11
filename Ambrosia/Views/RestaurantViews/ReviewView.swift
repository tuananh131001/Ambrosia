//
//  ReviewView.swift
//  Ambrosia
//
//  Created by Võ Quốc Huy on 10/09/2022.
//

import SwiftUI

struct ReviewView: View {
    var reviews:[Review]
    @State var isShowAddReview = false
    var body: some View {
        GeometryReader{
            geo in
            ZStack(alignment:.bottomTrailing){
                ScrollView(showsIndicators:false){
                    LazyVStack(alignment:.leading,spacing:35){
                        ForEach(0..<reviews.count,id: \.self){
                            index in
                            ReviewCard(rating: reviews[index].rating, review: reviews[index])
                        }
                    }
                }
                Button {
                    isShowAddReview = true
                } label: {
                    CircleButtonView(buttonImage: "square.and.pencil")
                
                }.sheet(isPresented: $isShowAddReview) {
                    AddReviewView(restaurant: Restaurant.testRestaurant(), review: Review.testReviews()[0])
                }
            }.padding([.trailing,.leading],30)
            
        }.background(Color("CardBackgroundColor"))
        
    }
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView(reviews: Review.testReviews())
    }
}
