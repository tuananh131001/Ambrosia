// https://onmyway133.com/posts/how-to-use-foreach-with-indices-in-swiftui/
// https://swiftbysundell.com/articles/stroking-and-filling-a-swiftui-shape-at-the-same-time

import SwiftUI


struct FavouriteRestaurantView: View {
    @EnvironmentObject var restaurantModel: RestaurantModel
    @EnvironmentObject var userModel: UserModel

    var cardWidth: CGFloat = 0.0
    @State var imageSize: CGFloat = 0.0
    var cardHeight: CGFloat = 135.0
    var paddingTopTitle: CGFloat = 60
    var barTitle: some View {
        Text("\(userModel.user.name)'s Favorite")
            .font(.title)
            .bold()
            .foregroundColor(Constants.PRIMARY_COLOR)
    }
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                ZStack {
                    BackgroundImage(name: "favorite-bck\(userModel.user.isDarkModeOn ? "-dark" : "")", brightness: -0.01, contrast: 1, opacity: 0.3)
                        .background(Constants.BCK_COLOR)
                    if (userModel.user.favouriteRestaurants.count != 0) {
                        VStack(alignment: .leading, spacing: 50) {
                            ScrollView {
                                VStack(spacing: 30) {
                                    ForEach(userModel.user.favouriteRestaurants, id: \.placeId) { rest in
                                        FavoriteCard(imageSize: imageSize, cardHeight: cardHeight, geo: geo, rest: rest)
                                    }
                                }
                            }
                                .onAppear() {
                                imageSize = 120
                            }
                                .frame(width: geo.size.width)
                        }
                        .padding(.top, paddingTopTitle)
                    }
                    else {
                        FavoriteNotFound(geo: geo)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        HStack {
                            barTitle
                            Spacer()
                        }
                        .padding(.top, paddingTopTitle)

                    }
                }
            }
        }
    }

}
