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
    @State private var tabSelection = 1
    
    @EnvironmentObject var model: RestaurantModel
    
    init() {
        // Customize the tab bar for the whole app
        UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance.init(idiom: .unspecified)
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color("PlaceHolderText"))
        UITabBar.appearance().barTintColor = UIColor(Color("PrimaryColor"))
    }
    
    var body: some View {
        TabView(selection:$tabSelection){
            //  Main feature character view
            RestaurantListView().tabItem {
                VStack{
                    Image(systemName: "house.circle")
                        .resizable()
                    Text("Home")
                }
            }.tag(1)
            //  Comics display by list
            FavouriteRestaurantView().tabItem {
                VStack{
                    Image(systemName: "heart.circle").foregroundColor(.red)
                    Text("Favourite")
                    
                }
            }.tag(2)
            // BookStore display by list
            SettingView().tabItem {
                VStack{
                    Image(systemName:"gear.circle")
                    Text("Profile")
                }
            }.tag(3)
        }.accentColor(Color("PrimaryColor"))
    }
    
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
                .environmentObject(RestaurantModel())
        }
    }
}
