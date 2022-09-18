/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 3
    Author: Vo Quoc Huy
    ID: s3823236
    Created  date: 16/09/2022
    Last modified: 17/09/2022
    Acknowledgement:
    - Canvas
*/

import SwiftUI

struct RatingContributionView: View {
    @EnvironmentObject var restaurantModel: RestaurantModel
    @State var rating: Int
    var body: some View {

        HStack(spacing: 15) {
            // MARK: display rating as 5 stars
            VStack(spacing: 10) {
                Text("\(restaurantModel.currentRestaurant?.totalScore ?? 0, specifier: "%.1f")").bold().foregroundColor(Color("TextColor")).font(.system(size: 22))
                RatingView(rating: $rating, tappable: false, width: 12, height: 12)
                Text("\(restaurantModel.currentRestaurant?.reviewsCount ?? 5) ratings").foregroundColor(Color("SubTextColor")).font(.system(size: 12))
            }
            
            Divider().frame(height: 100)
            
            // MARK: ratings in details with progress slider
            VStack {
                ProgressSlider(number: 5)
                ProgressSlider(number: 4)
                ProgressSlider(number: 3)
                ProgressSlider(number: 2)
                ProgressSlider(number: 1)

            }
        }

    }
}

struct RatingContributionView_Previews: PreviewProvider {
    static var previews: some View {
        RatingContributionView(rating: 4).environmentObject(RestaurantModel())
    }
}
