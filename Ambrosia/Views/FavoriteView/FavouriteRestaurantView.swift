// https://onmyway133.com/posts/how-to-use-foreach-with-indices-in-swiftui/

import SwiftUI


struct FavouriteRestaurantView: View {
    @EnvironmentObject var restaurantModel: RestaurantModel
    @EnvironmentObject var userModel: UserModel

    @State var cardWidth: CGFloat = 0.0
    @State var imageSize: CGFloat = 0.0

    @State var contentWidth: CGFloat = 0.0
    @State var starSize: CGFloat = 0.0
    @State var distanceSize: CGFloat = 0.0
    @State var openSize: CGFloat = 0.0
    @State var titleSize: CGFloat = 0.0



    var body: some View {
        GeometryReader { geo in
            NavigationView {
                VStack(alignment: .leading, spacing: 50) {
                    if (userModel.user.favouriteRestaurants.count != 0) {
                        ScrollView {
                            ForEach(userModel.user.favouriteRestaurants, id: \.placeId) { rest in
                                NavigationLink(
                                    tag: restaurantModel.findRestaurantIndexById(rest.placeId ?? ""),
                                    selection: $restaurantModel.restaurantSelected) {
                                    // find the current restaurant and display when the view appear
                                    RestaurantDetailView().onAppear {
                                        restaurantModel.getCurrentRestaurant(placeId: rest.placeId ?? "")
                                    }

                                } label: {
                                    ZStack {
                                        Rectangle()
                                            .foregroundColor(Color("CardBackgroundColor"))
                                            .modifier(LightShadowModifier())

                                        FavoriteContent(imageSize: imageSize, titleSize: titleSize, starSize: starSize, distanceSize: distanceSize, openSize: openSize, contentWidth: contentWidth, rest: rest)
                                            .frame(height: imageSize)

                                    }

                                        .frame(height: imageSize + imageSize / 2.5, alignment: .center)
                                        .cornerRadius(10)
                                }


                            }
                        }
                            .onAppear() {
                            cardWidth = geo.size.width / 1.1
                            imageSize = cardWidth / 3

                            starSize = geo.size.width / 30
                            distanceSize = geo.size.width / 27
                            openSize = geo.size.width / 25
                            titleSize = geo.size.width / 21

                        }
                    }
                    else {
                        NotFoundView()
                    }
                }

                    .background(Constants.BCK_COLOR)
                    .navigationBarBackButtonHidden(true)
                    .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("Your Favorite".uppercased())
                            .font(.title)
                            .foregroundColor(Constants.PRIMARY_COLOR)
                    }
                }
            }


        }
    }

}
