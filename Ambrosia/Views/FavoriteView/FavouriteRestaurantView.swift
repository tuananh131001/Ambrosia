// https://onmyway133.com/posts/how-to-use-foreach-with-indices-in-swiftui/

import SwiftUI

struct ListElem: View {

    @State private var offset = CGSize.zero
    @State private var isDragging = false
    @GestureState var isTapping = false

    var body: some View {

        // Gets triggered immediately because a drag of 0 distance starts already when touching down.
        let tapGesture = DragGesture(minimumDistance: 0)
            .updating($isTapping) { _, isTapping, _ in
            isTapping = true
        }

        // minimumDistance here is mainly relevant to change to red before the drag
        let dragGesture = DragGesture(minimumDistance: 0)
            .onChanged { offset = $0.translation }
            .onEnded { _ in
            withAnimation {
                offset = .zero
                isDragging = false
            }
        }

        let pressGesture = LongPressGesture(minimumDuration: 1.0)
            .onEnded { value in
            withAnimation {
                isDragging = true
            }
        }

        // The dragGesture will wait until the pressGesture has triggered after minimumDuration 1.0 seconds.
        let combined = pressGesture.sequenced(before: dragGesture)

        // The new combined gesture is set to run together with the tapGesture.
        let simultaneously = tapGesture.simultaneously(with: combined)

        return Circle()
            .overlay(isTapping ? Circle().stroke(Color.red, lineWidth: 5) : nil) //listening to the isTapping state
        .frame(width: 100, height: 100)
            .foregroundColor(isDragging ? Color.red : Color.black) // listening to the isDragging state.
        .offset(offset)
            .gesture(simultaneously)

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
                    ScrollView() {
                        ForEach(0..<userModel.user.favouriteRestaurants.count, id: \.self) { index in
                            HStack {
//                                RestaurantAsyncImage(photo_id: userModel.user.favouriteRestaurants[index].imageUrls?[0] ?? "testRestaurant").frame(width: imageSize, height: imageSize).cornerRadius(10)
                                VStack(alignment: .leading) {
                                    Text("Hello")
                                    
                                }
                                ListElem()
                                
                            }
//                                .frame(maxWidth: .infinity)
                        }
                    }
//                    ScrollView {
//                        ForEach(0..<userModel.user.favouriteRestaurants.count, id: \.self) { index in
//                            HStack {
//                                RestaurantAsyncImage(photo_id: userModel.user.favouriteRestaurants[index].imageUrls?[0] ?? "testRestaurant").frame(width: imageSize, height: imageSize).cornerRadius(10)
//                                VStack(alignment: .leading, spacing: 4) {
//                                    // MARK: rating
////                                    FavoriteRating(index: index, starSize: starSize, titleSize: titleSize)
//                                    HStack {
//                                        Text("\(userModel.user.favouriteRestaurants[index].totalScore ?? 5.0, specifier: "%.1f")")
//                                            .font(.system(size: starSize + 4))
//                                            .foregroundColor(Color("Fv Special Clr 2"))
//                                        ImageSystemHier(name: "star.fill", color: "Star On Color", size: starSize)
//
//                                        Spacer()
//
//                                        Button {
//                                            print("Click")
//                                            print("sir index \(index)")
//                                            userModel.user.favouriteRestaurants[index].isFavorite = firebaseService.changeFavorites(userModel: userModel, restaurant: userModel.user.favouriteRestaurants[index])
//
//                                        } label: {
//                                            ImageSystemHier(name: "heart\(userModel.user.favouriteRestaurants[index].isFavorite ? ".fill" : "")", color: "Close Color", size: titleSize)
//                                        }
//
//                                    }
//
//                                    // MARK: name
//                                    Text(userModel.user.favouriteRestaurants[index].title)
//                                        .lineLimit(1)
//                                        .foregroundColor(Color("Fv Title Clr"))
//                                        .font(.system(size: titleSize))
//
//                                    // MARK: side info
//                                    FavoriteSideInfo(distanceSize: distanceSize, restaurant: userModel.user.favouriteRestaurants[index])
//
//                                    Spacer()
//
//                                    // MARK: Open State
//                                    FavoriteOpen(isOpen: true, openSize: openSize)
//                                }
//                                Spacer()
//                            }
//                                .onAppear() {
//                                imageSize = geo.size.width / 3
//                                starSize = geo.size.width / 30
//                                distanceSize = geo.size.width / 27
//                                openSize = geo.size.width / 25
//                                titleSize = geo.size.width / 21
//                                    clickFavourites = Array(repeating: false, count: userModel.user.favouriteRestaurants.count)
//
//                            }
//
//                        }
//                    }
                }
                    .navigationTitle("Favourite")

            }
        }

    }
}
