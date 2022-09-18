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

struct ReviewCard: View {
    @EnvironmentObject var restaurantModel:RestaurantModel
    @State var rating:Int
    @State var reviewerAvatar:String = ""
    @State var reviewerUsername:String = ""
    var review:Review
    
    var body: some View {
        VStack (alignment:.leading,spacing:15){
            HStack{
                // MARK: loading image of a user for each review
                AsyncImage(url: URL(string: reviewerAvatar)) { image in
                    image
                        .resizable().aspectRatio(contentMode: .fill).frame(width: 50, height: 50).clipShape(Circle())
                } placeholder: {
                    Image("avatar1").resizable().aspectRatio(contentMode: .fill).frame(width: 40, height: 40).clipShape(Circle())
                }
                // MARK: username of a user
                Text(reviewerUsername).foregroundColor(Color("TextColor")).bold().font(.system(size: 20))
            }
            HStack{
                // MARK: rating the user gave
                RatingView(rating: $rating, tappable: false,width: 12,height: 12)
                // separator
                Text("•").foregroundColor(Color("TextColor")).bold().font(.system(size: 14))
                // MARK: date create that review
                Text(FormatDate.convertDateToString(formatDay: review.dateCreated)).foregroundColor(Color("SubTextColor")).font(.system(size: 14))
            }
            // MARK: detailed review description
            Text(review.reviewDescription).foregroundColor(Color("TextColor")).font(.system(size: 17))
            // MARK: check if review helpful
            HStack(spacing:10){
                Button {
                    // TODO: Pass correct review from the restaurant detail list to use
                    restaurantModel.updateLikeForReview(id: review.id)
                } label: {
                    Image(systemName: !review.isLiked ? "hand.thumbsup" : "hand.thumbsup.fill").resizable().aspectRatio(contentMode: .fit).frame(width: 20, height: 14).foregroundColor(Color("SecondaryColor"))
                    Text(!review.isLiked ? "Helpful?" : "").foregroundColor(Color("SubTextColor")).font(.system(size: 14)).bold()
                }
            }
        }.onAppear(perform: {
            // get avatar of user
            restaurantModel.firebaseService.getUserAvatar(userId: review.userId)  { newAvatar in
                reviewerAvatar = newAvatar
            } setUserName: { newUsername in
                reviewerUsername = newUsername
            }
            
        })
    }
}

struct ReviewCard_Previews: PreviewProvider {
    static var previews: some View {
        ReviewCard(rating:3,review: Review.testReviews()[0])
    }
}
