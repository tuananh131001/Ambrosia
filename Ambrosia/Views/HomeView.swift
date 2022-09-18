/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 3
 Author: Tran Mai Nhung, Vo Quoc Huy
 ID: s3879954, s3823236
 Created  date: 9/09/2022
 Last modified: 17/09/2022
 Acknowledgement:
 - Canvas, CodeWithChris Course
 - https://www.hackingwithswift.com/quick-start/swiftui/how-to-add-a-search-bar-to-filter-your-data
 - https://stackoverflow.com/questions/56505528/swiftui-update-navigation-bar-title-color
 */

import SwiftUI

import CoreLocation
import MapKit

struct HomeViewContent: View {
    @Binding var isShowingMap: Bool
    @Binding var searchQuery: String
    @Binding var tabSelection: Int
    
    @EnvironmentObject var model: RestaurantModel
    @EnvironmentObject var userModel: UserModel
    
    //    @AppStorage("isDarkMode") private var isDarkMode = false
    /*
     @EnvironmentObject var viewModel: AuthenticationModel
     
     init() {
     // Customize the tab bar for the whole app
     UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance.init(idiom: .unspecified)
     UITabBar.appearance().unselectedItemTintColor = UIColor(Color("PlaceholderText"))
     UITabBar.appearance().barTintColor = UIColor(Color("PrimaryColor"))
     }
     */
    
    
    var body: some View {
        // View on home view
        TabView(selection: $tabSelection) {
            // MARK: Main feature character view
            RestaurantListView().tabItem {
                VStack {
                    Image(systemName: "house.circle")
                        .resizable()
                    Text("Home")
                }
            }.tag(1)
            
            // MARK:  Comics display by list
            FavouriteRestaurantView().tabItem {
                VStack {
                    Image(systemName: "heart.circle").foregroundColor(.red)
                    Text("Favourite")
                }
            }.tag(2)
            
            // MARK:  BookStore display by list
            SettingView().tabItem {
                VStack {
                    Image(systemName: "gear.circle")
                    Text("Profile")
                }
            }.tag(3)
        }
        .accentColor(Color("PrimaryColor"))
        .onAppear() {
            ThemeViewUtil.setAppTheme(userModel)
        }
        .onChange(of: tabSelection) { newValue in
            // click tab item -> sound effect
            SoundModel.clickTabSound()
        }
    }
}
struct HomeView: View {
    @State var isShowingMap = false
    @State var searchQuery = ""
    @State private var tabSelection = 1
    
    @EnvironmentObject var restaurantModel: RestaurantModel
    
    init() {
        // Customize the tab bar for the whole app
        UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance.init(idiom: .unspecified)
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color("PlaceholderText"))
        UITabBar.appearance().barTintColor = UIColor(Color("PrimaryColor"))
    }
    
    var body: some View {
        // if not ask user location yet
        if restaurantModel.authorizationState == .notDetermined {
            HomeViewContent(isShowingMap: $isShowingMap, searchQuery: $searchQuery, tabSelection: $tabSelection)
                .onAppear() {
                    restaurantModel.requestGeolocationPermission()
                }
        }
        // user allow access to location
        else if restaurantModel.authorizationState == .authorizedAlways || restaurantModel.authorizationState == .authorizedWhenInUse {
            
            HomeViewContent(isShowingMap: $isShowingMap, searchQuery: $searchQuery, tabSelection: $tabSelection)
                .onAppear() {
                    restaurantModel.chooseDefaultLocation()
                }
            
        }
        // user not allow -> open settings
        else {
            
            HomeViewContent(isShowingMap: $isShowingMap, searchQuery: $searchQuery, tabSelection: $tabSelection)
                .onAppear() {
                    // Open settings by getting the settings url
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        if UIApplication.shared.canOpenURL(url) {
                            // If we can open this settings url, then open it
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                    }
                }
        }
        
    }
}
