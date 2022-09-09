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
    
    @EnvironmentObject var model: RestaurantModel
    @State var searchQuery = ""
    
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                ScrollView {
                    VStack {
                        if searchQuery.isEmpty {
                            // MARK: - display random restaurant
                            NavigationLink(destination: {
                                let randRest = model.currentRandomRestaurant ?? Restaurant()
                                RestaurantDetailView(rest: randRest)
                                    .onAppear() {
                                        model.navigateRestaurant(randRest.id)
                                    }
                            }, label: {
                                ZStack {
                                    // background image
                                    Image("random-eat")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .brightness(-0.3)
                                    // shadow to background image
                                    ImageShadowView(opacity: 0.8, gradient: Color.backgroundGradient)
                                    
                                    // text
                                    VStack(alignment: .leading) {
                                        Spacer()
                                        Text("Today, let's eat...")
                                            .font(.title2)
                                            .bold()
                                            .italic()
                                        Spacer()
                                        HStack {
                                            // random text option display
                                            Spacer()
                                            Text(model.currentRandomRestaurant?.name.uppercased() ?? "")
                                                .font(Font.custom("GermaniaOne-Regular", size: 50))
                                                .bold()
                                                .lineLimit(1)
                                                .shadow(radius: 0.5)
                                        }
                                        Spacer()
                                    }
                                    .foregroundColor(.white)
                                    .padding()
                                }
                            })
                            
                            // MARK: - Display popular restaurants
                            PopularRestaurantsView()
                        }
                        
                        // MARK: - Display restaurant when searching and display all restaurants
                        VStack(alignment: .leading) {
                            // if search found or user searches nothing
                            if filteredSearchRestaurant.count != 0 {
                                Text("All Restaurants")
                                    .font(.largeTitle)
                                    .bold()
                                    .padding(.top, searchQuery.isEmpty ? 0 : 10)
                                VStack(spacing: searchQuery.isEmpty ? 45 : 30) {
                                    // MARK: display 1 restaurant
                                    ForEach(filteredSearchRestaurant) { item in
                                        // if user does not use search feature
                                        if searchQuery.isEmpty {
                                            NavigateLink(
                                                destinationView: AnyView(RestaurantDetailView(rest: item)),
                                                labelView: AnyView(RestaurantCardView(rest: item, cardWidth: UIScreen.main.bounds.width - 30, cardHeight: 357, displayType: "all")),
                                                navigateMethod: { model.navigateRestaurant(item.id) })
                                        } else {
                                            // if user uses search feature and search found
                                            NavigateLink(
                                                destinationView: AnyView(RestaurantDetailView(rest: item)),
                                                // display label view if the user is searching or not
                                                labelView: AnyView(RestaurantSearchCardView(rest: item)
                                                    .frame(width: UIScreen.main.bounds.width - 30)),
                                                navigateMethod: { model.navigateRestaurant(item.id) })
                                        }
                                    }
                                }
                            } else {
                                // if search not found
                                Spacer()
                                NotFoundView(message: "Not Found _\(searchQuery)_ Restaurant")
                                    .padding()
                                Spacer()
                            }
                        }
                        
                    }
                    // add frame
                    .frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        minHeight: 0,
                        maxHeight: .infinity,
                        alignment: .center
                    )
                    // placement helps always display search bar when scroll
                    .searchable(text: $searchQuery, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search Restaurants By Name") {
                        // suggestions for user when typing
                        ForEach(filteredSearchRestaurant) { rest in
                            HStack(spacing: 4) {
                                Image(systemName: "magnifyingglass")
                                    .padding(.trailing, 10)
                                Text("Are you looking for")
                                    .foregroundColor(.black)
                                Text(rest.name)
                                    .bold()
                                    .lineLimit(1)
                                    .foregroundColor(Color("RestDetailTitleColor"))
                                
                            }
                            .searchCompletion(rest.name)
                        }
                    }
                }
                
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
            
        }
        
    }
    
    // Result of search about list search restaurants
    var filteredSearchRestaurant: [Restaurant] {
        // search function
        if searchQuery.isEmpty {
            return model.restaurants
        }
        else {
            // if user types text to search
            return model.restaurants.filter {
                $0.name.lowercased().contains(searchQuery.lowercased())
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(RestaurantModel())
    }
}
