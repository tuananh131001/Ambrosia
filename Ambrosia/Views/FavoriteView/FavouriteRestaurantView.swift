// https://onmyway133.com/posts/how-to-use-foreach-with-indices-in-swiftui/
// https://swiftbysundell.com/articles/stroking-and-filling-a-swiftui-shape-at-the-same-time

import SwiftUI


struct FavouriteRestaurantView: View {
    @EnvironmentObject var restaurantModel: RestaurantModel
    @EnvironmentObject var userModel: UserModel

    @State var cardWidth: CGFloat = 0.0
    @State var imageSize: CGFloat = 0.0
    @State var cardHeight: CGFloat = 135.0



    var body: some View {
        GeometryReader { geo in
            NavigationView {

                ZStack {
                    BackgroundImage(name: "favorite-bck\(userModel.user.isDarkModeOn ? "-dark" : "")", brightness: -0.01, contrast: 1, opacity: 0.3)
                        .background(Constants.BCK_COLOR)
                    VStack(alignment: .leading, spacing: 50) {
                        if (userModel.user.favouriteRestaurants.count != 0) {
                            ScrollView {
                                VStack(spacing: 30) {
                                    ForEach(userModel.user.favouriteRestaurants, id: \.placeId) { rest in
                                        NavigationLink(
                                            tag: restaurantModel.findRestaurantIndexById(rest.placeId ?? ""),
                                            selection: $restaurantModel.restaurantSelected) {
                                            // find the current restaurant and display when the view appear
                                            RestaurantDetailView().onAppear {
                                                // MARK: action
                                                restaurantModel.getCurrentRestaurant(placeId: rest.placeId ?? "")
                                            }

                                        } label: {
                                            // MARK: view
                                            HStack {
                                                ZStack {
                                                    ArrowShape()
                                                        .fill(Constants.CARD_BCK_COLOR)
                                                        .frame(width: geo.size.width * 0.9, height: cardHeight, alignment: .trailing)
                                                        .modifier(NormalShadowModifier())

                                                    FavoriteContent(imageSize: imageSize, rest: rest)
                                                        .frame(width: geo.size.width * 0.7, height: cardHeight, alignment: .leading)
                                                }
                                                Spacer()
                                            }

                                        }
                                            .edgesIgnoringSafeArea(.horizontal)


                                    }
                                }
                            }
                                .onAppear() {
                                //                            imageSize = cardWidth / 3
                                imageSize = 80
                            }
                                .edgesIgnoringSafeArea(.horizontal)
                                .frame(width: geo.size.width)
                        }
                        else {
                            NotFoundView()
                        }
                    }
                }
                    .navigationBarBackButtonHidden(true)
                    .edgesIgnoringSafeArea(.horizontal)
                    .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("Your Favorite".uppercased())
                            .font(.title)
                            .foregroundColor(Constants.PRIMARY_COLOR)
                    }
                }
            }
                .edgesIgnoringSafeArea(.horizontal)
        }
    }

}
