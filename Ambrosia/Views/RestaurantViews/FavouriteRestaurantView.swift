// https://onmyway133.com/posts/how-to-use-foreach-with-indices-in-swiftui/

import SwiftUI

struct FavouriteRestaurantView: View {
    @EnvironmentObject var model: RestaurantModel
    @EnvironmentObject var userModel: UserModel
    @StateObject var firebaseService: FirebaseService = FirebaseService.services

    @State var imageSize: CGFloat = 0.0
    @State var starSize: CGFloat = 0.0
    @State var distanceSize: CGFloat = 0.0
    @State var openSize: CGFloat = 0.0
    @State var titleSize: CGFloat = 0.0

    @State var clickFavourite: Bool = false
//    @State var clickFavourites: [Bool]


    init() {
//        ratings = Array(repeating: 0, count: authModel.user.favouriteRestaurants.count)
//        openStates = Array(repeating: false, count: authModel.user.favouriteRestaurants.count)
//        clickFavourites = Array(repeating: false, count: userModel.user.favouriteRestaurants.count)
    }

    var body: some View {
        GeometryReader { geo in
            NavigationView {
                VStack {
                    ScrollView(.vertical) {
                        VStack {
                            ForEach(userModel.user.favouriteRestaurants, id: \.place_id) { r in
                                HStack {
                                    RestaurantAsyncImage(photo_id: r.photos?[0].photo_reference ?? "testRestaurant").frame(width: imageSize, height: imageSize).cornerRadius(10)
                                    VStack(alignment: .leading, spacing: 4) {
                                        // MARK: rating
                                        HStack {
                                            Text("\(r.rating ?? 5.0, specifier: "%.1f")")
                                                .font(.system(size: starSize + 4))
                                                .foregroundColor(Color("Fv Special Clr 2"))
                                            ImageSystemHier(name: "star.fill", color: "Star On Color", size: starSize)

                                            Button {
                                                withAnimation(.easeOut(duration: 0.5)) {
                                                    clickFavourite = firebaseService.changeFavorites(userModel: userModel, restaurant: r)
//                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//
//                                                    }
//                                                    clickFavourite = true
                                                }
                                            } label: {
                                                ImageSystemHier(name: "heart\(clickFavourite ? ".fill" : "")", color: "Close Color", size: titleSize)
                                                    .onAppear() {
                                                    clickFavourite = userModel.isRestaurantFavorite(restaurant: r) == nil ? false : true
                                                }
                                            }

                                        }

                                        // MARK: name
                                        Text(r.name)
                                            .lineLimit(1)
                                            .foregroundColor(Color("Fv Title Clr"))
                                            .font(.system(size: titleSize))

                                        // MARK: side info
                                        HStack(spacing: 5) {
                                            // MARK: Restaurant type
                                            Text("\(model.type ?? "Inexpensive")")
                                                .foregroundColor(Color("Fv Subtitle Clr"))
                                                .padding(.trailing, 3)
                                                .onAppear() {
                                                    model.getType(r.price_level)
                                                }

                                            Text("✼")
                                                .font(.system(size: distanceSize + 1))
                                                .foregroundColor(Color("Fv Special Clr"))
                                                .bold()

                                            // MARK: Restaurant distance
                                            HStack {
                                                ImageSystemHier(name: "car.fill", color: "Fv Subtitle Clr 2", size: distanceSize + 1)
                                                Text("\(r.distance, specifier: "%.2f")km")
                                                    .foregroundColor(Color("Fv Subtitle Clr 2"))
                                            }
                                        }
                                            .font(.system(size: distanceSize))
                                            .padding(.top, 3)

                                        Spacer()

                                        // MARK: Open State
                                        HStack(spacing: 3) {
                                            let isOpen = r.opening_hours?.open_now ?? true
                                            ImageSystemHier(name: "clock.badge.checkmark.fill", color: "Fv Subtitle Clr 2", size: openSize + 1)
                                            Text(isOpen ? "OPEN" : "CLOSED")
                                                .foregroundColor(Color("\(isOpen ? "Open" : "Close") Color"))
                                                .font(.system(size: openSize))
                                        }
                                    }
                                    Spacer()
                                }
                                .opacity(clickFavourite ? 1 : 0.5)
                                    .onAppear() {
                                    model.getType(r.price_level)
                                    imageSize = geo.size.width / 3
                                    starSize = geo.size.width / 30
                                    distanceSize = geo.size.width / 27
                                    openSize = geo.size.width / 25
                                    titleSize = geo.size.width / 21
                                        
                                        
                                }

                            }
                        }
                    }
                }
                    .navigationTitle("Favourite")

            }
        }

    }
}
