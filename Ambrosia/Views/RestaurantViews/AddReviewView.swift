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


struct AddReviewView: View {
    @EnvironmentObject var restaurantModel:RestaurantModel
    @EnvironmentObject var userModel:UserModel
    @Environment(\.presentationMode) var presentationMode
    @State private var rating:Int = 0
    @State private var userReview = ""
    
    var body: some View {
        GeometryReader{
            geo in
            VStack(alignment:.leading,spacing:20){
                VStack(spacing:10){
                    RestaurantAsyncImage(photo_id: restaurantModel.currentRestaurant?.imageLink ?? "").frame(width: geo.size.width, height: geo.size.height/4)
                    Spacer()
                    Text(restaurantModel.currentRestaurant?.title ?? "").foregroundColor(Color("TextColor")).bold().lineLimit(3).multilineTextAlignment(.center).frame(width: geo.size.width-50).font(.system(size: 16)).padding(.top,20)
                    Text(restaurantModel.currentRestaurant?.address ?? "").foregroundColor(Color("SubTextColor")).lineLimit(3).multilineTextAlignment(.center).frame(width: geo.size.width-50,height: 50).font(.system(size: 14))
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
                    SoundModel.clickButtonSound()
                    // Add Review from user
                    //TODO: Load restaurant from restaurant models
                    self.restaurantModel.addReviewFromUser(reviewDescription: userReview, rating: rating, name: userModel.user.name, email: userModel.user.email,userId:userModel.user.id, image: "avatar1",userModel:userModel)
                } label: {
                    RoundedButton(buttonText: "Submit", width: geo.size.width/1.1, height: 60,size: 16)
                }.padding(.horizontal)
                
            }
        }
    }
}

struct AddReview_Previews: PreviewProvider {
    static var previews: some View {
        AddReviewView().environmentObject(RestaurantModel())
    }
}
