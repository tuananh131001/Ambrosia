/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 3
    Author: Vo Quoc Huy
    ID: s3823236
    Created  date: 10/09/2022
    Last modified: 17/09/2022
    Acknowledgement:
    - Canvas
*/

import SwiftUI

struct ReviewView: View {
    @EnvironmentObject var restaurantModel:RestaurantModel
    @State var isShowAddReview = false
    var body: some View {
        GeometryReader {
            geo in
            if restaurantModel.currentRestaurant?.reviews.count == 0 {
                ZStack(alignment: .bottomTrailing){
                    ZStack{
                        GifView(name: "waiting")
                        VStack(spacing:20){
                            Text("This restaurant has not been reviewed yet.").foregroundColor(Color("TextColor"))
                            Button {
                                SoundModel.clickButtonSound()
                                isShowAddReview = true
                            } label: {
                                RoundedButton(buttonText: "ADD REVIEW", width: geo.size.width/2.4, height: geo.size.height/14,size: 16)

                            }.sheet(isPresented: $isShowAddReview) {
                                AddReviewView()
                            }
                        }.offset(y:110)
                    
                    }.frame(height:geo.size.height/1.7)
                 
                }.padding().frame(height:geo.size.height)
             
            }
            else{
                ZStack(alignment: .bottomTrailing) {
                    ScrollView(showsIndicators: false) {
                        LazyVStack(alignment: .leading, spacing: 35) {
                            ForEach(0..<(restaurantModel.currentRestaurant?.reviews.count ?? 0), id: \.self) {
                                index in
                                ReviewCard(rating: restaurantModel.currentRestaurant?.reviews[index].rating ?? 5, review: restaurantModel.currentRestaurant?.reviews[index] ?? Review.testReviews()[0])
                            }
                        }
                    }
                    Button {
                        isShowAddReview = true
                    } label: {
                        CircleButtonView(buttonImage: "square.and.pencil")

                    }.sheet(isPresented: $isShowAddReview) {
                        AddReviewView()
                    }
                }.padding([.trailing, .leading], 30).padding(.top,30)
            }
        }.background(Color("CardBackgroundColor")).onAppear(perform: {
            restaurantModel.firebaseService.fetchReviewFromFirebase(restaurant: restaurantModel.currentRestaurant ?? Restaurant.testRestaurantDetail(),model:restaurantModel)

        })

    }
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
//        ReviewView(reviews: Review.testReviews())
        ReviewView().environmentObject(RestaurantModel())

    }
}
