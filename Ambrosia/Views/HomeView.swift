/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Tran Mai Nhung
 ID: s3879954
 Created  date: 19/07/2022
 Last modified: 07/08/2022
 Acknowledgement:
 - Canvas, CodeWithChris Course
 - https://www.hackingwithswift.com/quick-start/swiftui/how-to-add-a-search-bar-to-filter-your-data
 - https://stackoverflow.com/questions/56505528/swiftui-update-navigation-bar-title-color
 */

import SwiftUI

struct HomeView: View {
    @State var isShowingMap = false
    @State var searchQuery = ""

    @EnvironmentObject var model: RestaurantModel



    var body: some View {

        VStack {
//            Button("Button title") {
//                model.fetchRestaurant
//            }

//            List (newRestaurantModel.results, id: \.place_id) {
//                res in
//                Text("Name : \(res.name)")
//            }
            NavigationView {
                RestaurantList()
                // placement helps always display search bar when scroll
//                        .searchable(text: $searchQuery, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search Restaurants By Name") {
//                            // suggestions for user when typing
//                            ForEach(filteredSearchRestaurant, id: \.place_id) { rest in
//                                HStack(spacing: 4) {
//                                    Image(systemName: "magnifyingglass")
//                                        .padding(.trailing, 10)
//                                    Text("Are you looking for")
//                                        .foregroundColor(.black)
//                                    Text(rest.name)
//                                        .bold()
//                                        .lineLimit(1)
//                                        .foregroundColor(Color("RestDetailTitleColor"))
//
//                                }
//                                    .searchCompletion(rest.name)
//                            }
//                        }
            }
            // for display navigation items: App Title + Random Button
            .navigationBarTitleDisplayMode(.inline)
                .toolbar(content: {
                ToolbarItem(placement: .principal) {
                    HStack {
                        // App Title
                        Text("EAT TIME!!")
                            .font(Font.custom("GermaniaOne-Regular", size: 40))
                            .bold()

                        Spacer()

                        // Random Button
                        Button(action: {
                            model.currentRandomRestaurant = model.restaurants.randomElement()
                        }, label: {
                                Image(systemName: "dice.fill")
                                    .shadow(radius: 0.5)
                            })
                    }
                        .foregroundColor(Color("RestDetailTitleColor"))
                }
            })
        }.onAppear(perform: model.fetchRestaurant)
// Result of search about list search restaurants
//    var filteredSearchRestaurant: [Restaurant] {
//        // search function
//        if searchQuery.isEmpty {
//            return newRestaurantModel.results
//        }
//        else {
//            // if user types text to search
//            return model.restaurants.filter {
//                $0.name.lowercased().contains(searchQuery.lowercased())
//            }
//        }
//    }
    }

    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
                .environmentObject(RestaurantModel())
        }
    }
}
