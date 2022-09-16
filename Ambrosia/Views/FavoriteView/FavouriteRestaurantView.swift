// https://onmyway133.com/posts/how-to-use-foreach-with-indices-in-swiftui/

import SwiftUI
struct Background1: View {
  var body: some View {
     RoundedRectangle(cornerRadius: 10)
       .foregroundColor(.green)
     }
 }
struct FavouriteRestaurantView: View {
    @EnvironmentObject var model: RestaurantModel
    @EnvironmentObject var userModel: UserModel
    @StateObject var firebaseService: FirebaseService = FirebaseService.services

    @State var imageSize: CGFloat = 0.0
    @State var starSize: CGFloat = 0.0
    @State var distanceSize: CGFloat = 0.0
    @State var openSize: CGFloat = 0.0
    @State var titleSize: CGFloat = 0.0

//    @State var clickFavourite: Bool = false
    @State var clickFavourites: [Bool] = [Bool]()



    var body: some View {
        GeometryReader { geo in
            NavigationView {
//                Button(action: {print("Click")}, label: {Text("Navigation")})
                VStack {
                    Button(action: {print("Click sir")}, label: {Text("VSt")})
                        .onTapGesture {
                            print("Tap Sir")
                        }
                    ScrollView {
                        Button(action: {}, label: {Text("Scroll")})
                            .onTapGesture {
                                print("Tap Sir Scroll")
                            }
                            .mask(Background1())
                        Text("Hello")
                            .onTapGesture {
                                print("Hello sir")
                            }
                        VStack {
                            ForEach(0..<userModel.user.favouriteRestaurants.count, id: \.self) { index in
                                HStack {
                                    RestaurantAsyncImage(photo_id: userModel.user.favouriteRestaurants[index].imageUrls?[0] ?? "testRestaurant").frame(width: imageSize, height: imageSize).cornerRadius(10)
                                    VStack(alignment: .leading, spacing: 4) {
                                        // MARK: rating
    //                                    FavoriteRating(index: index, starSize: starSize, titleSize: titleSize)
                                        HStack {
                                            Text("\(userModel.user.favouriteRestaurants[index].totalScore ?? 5.0, specifier: "%.1f")")
                                                .font(.system(size: starSize + 4))
                                                .foregroundColor(Color("Fv Special Clr 2"))
                                            ImageSystemHier(name: "star.fill", color: "Star On Color", size: starSize)

                                            Spacer()
                                            
                                            Button {
                                                print("Click")
                                                print("sir index \(index)")
                                                userModel.user.favouriteRestaurants[index].isFavorite = firebaseService.changeFavorites(userModel: userModel, restaurant: userModel.user.favouriteRestaurants[index])
                                                
                                            } label: {
                                                ImageSystemHier(name: "heart\(userModel.user.favouriteRestaurants[index].isFavorite ? ".fill" : "")", color: "Close Color", size: titleSize)
                                            }

                                        }

                                        // MARK: name
                                        Text(userModel.user.favouriteRestaurants[index].title)
                                            .lineLimit(1)
                                            .foregroundColor(Color("Fv Title Clr"))
                                            .font(.system(size: titleSize))

                                        // MARK: side info
                                        FavoriteSideInfo(distanceSize: distanceSize, restaurant: userModel.user.favouriteRestaurants[index])

                                        Spacer()

                                        // MARK: Open State
                                        FavoriteOpen(isOpen: true, openSize: openSize)
                                    }
                                    Spacer()
                                }
                                    .onAppear() {
                                    imageSize = geo.size.width / 3
                                    starSize = geo.size.width / 30
                                    distanceSize = geo.size.width / 27
                                    openSize = geo.size.width / 25
                                    titleSize = geo.size.width / 21
                                        clickFavourites = Array(repeating: false, count: userModel.user.favouriteRestaurants.count)

                                }

                            }
                        }
                    }
                    .onTapGesture {
                    }
                }
                    .navigationTitle("Favourite")

            }
        }

    }
}
