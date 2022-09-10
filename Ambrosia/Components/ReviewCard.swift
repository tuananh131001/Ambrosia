//
//  ReviewCard.swift
//  Ambrosia
//
//  Created by Võ Quốc Huy on 10/09/2022.
//

import SwiftUI

struct ReviewCard: View {
    @State var rating:Int
    var review:Review
    var body: some View {
        VStack (alignment:.leading,spacing:15){
            HStack{
                Image(review.image).resizable().aspectRatio(contentMode: .fill).frame(width: 50, height: 50).clipShape(Circle())
                Text(review.username).foregroundColor(Color("TextColor")).bold().font(.system(size: 20))
            }
            HStack{
                RatingView(rating: $rating, tappable: false,width: 12,height: 12)
                Text("•").foregroundColor(Color("TextColor")).bold().font(.system(size: 14))
                Text(FormatDate.convertDateToString(formatDay: review.dateCreated)).foregroundColor(Color("TextColor")).font(.system(size: 14))
            }
            Text(review.reviewDescription).foregroundColor(Color("TextColor")).font(.system(size: 17))
            HStack(spacing:10){
                Image(systemName: !review.isLiked ? "hand.thumbsup" : "hand.thumbsup.fill").resizable().aspectRatio(contentMode: .fit).frame(width: 20, height: 14)
                Text(!review.isLiked ? "Helpful?" : "").foregroundColor(Color("TextColor")).font(.system(size: 14))
            }
        }
    }
}

struct ReviewCard_Previews: PreviewProvider {
    static var previews: some View {
        ReviewCard(rating:3,review: Review.testReviews()[0])
    }
}
