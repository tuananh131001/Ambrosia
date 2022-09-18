/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 3
 Author: Tran Mai Nhung
 ID: s3879954
 Created  date: 15/09/2022
 Last modified: 17/09/2022
 Acknowledgement:
 - Canvas
 - https://onmyway133.com/posts/how-to-use-foreach-with-indices-in-swiftui/
 - https://swiftbysundell.com/articles/stroking-and-filling-a-swiftui-shape-at-the-same-time
 */


import SwiftUI


struct FavouriteRestaurantView: View {
    @EnvironmentObject var restaurantModel: RestaurantModel
    @EnvironmentObject var userModel: UserModel
    
    var cardWidth: CGFloat = 0.0
    var imageSize: CGFloat = 120
    var cardHeight: CGFloat = 135.0
    var barTitle: some View {
        Text("\(userModel.user.name)'s Favorite")
            .font(.title)
            .bold()
            .foregroundColor(Constants.PRIMARY_COLOR)
    }
    @State private var searchText = ""
    var searchResults: [Restaurant] {
        // if the search bar is empty -> show all
        if searchText.isEmpty {
            return userModel.user.favouriteRestaurants
            
            
        } else {
            return userModel.user.favouriteRestaurants.filter{ $0.title.localizedCaseInsensitiveContains(searchText)
            }
        }
        
    }
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                ZStack {
                    if !userModel.user.isDarkModeOn {
                        BackgroundImage(name: "favorite-bck", brightness: -0.01, contrast: 1, opacity: 0.3)
                    }
                    else {
                        Constants.BCK_COLOR
                            .edgesIgnoringSafeArea(.all)
                    }
                        
                    if (userModel.user.favouriteRestaurants.count != 0) {
                        VStack(alignment: .leading, spacing: 50) {
                            ScrollView {
                                VStack(spacing: 30) {
                                    ForEach(searchResults, id: \.placeId) { rest in
                                        FavoriteCard(imageSize: imageSize, cardHeight: cardHeight, geo: geo, rest: rest)
                                    }
                                }
                            }
                        }.searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search by restaurant's name")
                    }
                    else {
                        FavoriteNotFound(geo: geo)
                    }
                }
                .navigationTitle("\(userModel.user.name)'s Favorites")
            }.navigationViewStyle(StackNavigationViewStyle())
        }
    }
    
}
