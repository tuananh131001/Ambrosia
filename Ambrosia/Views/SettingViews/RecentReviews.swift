//
//  RecentReviews.swift
//  Ambrosia
//
//  Created by William on 16/09/2022.
//

import SwiftUI

struct RecentReviews: View {
    @EnvironmentObject var userModel:UserModel
    var body: some View {
        List(userModel.user.reviewRestaurant,id:\.placeId){review in
            Text(review.title)
        }
    }
}

struct RecentReviews_Previews: PreviewProvider {
    static var previews: some View {
        RecentReviews()
    }
}
