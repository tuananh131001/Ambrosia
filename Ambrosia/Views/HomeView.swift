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

import CoreLocation
import MapKit

struct HomeViewContent: View {
    @Binding var isShowingMap: Bool
    @Binding var searchQuery: String
    @Binding var tabSelection: Int
    
    @EnvironmentObject var model: RestaurantModel
    var body: some View {
        TabView(selection: $tabSelection) {
            //  Main feature character view
            RestaurantListView().tabItem {
                VStack {
                    Image(systemName: "house.circle")
                        .resizable()
                    Text("Home")
                }
            }.tag(1)
            //  Comics display by list
            FavouriteRestaurantView().tabItem {
                VStack {
                    Image(systemName: "heart.circle").foregroundColor(.red)
                    Text("Favourite")
               
                    
                }
            }.tag(2)
            // BookStore display by list
            SettingView().tabItem {
                VStack {
                    Image(systemName: "gear.circle")
                    Text("Profile")
                }
            }.tag(3)
        }
        .accentColor(Color("PrimaryColor"))
    }
}
struct HomeView: View {
    @State var isShowingMap = false
    @State var searchQuery = ""
    @State private var tabSelection = 1
    
    @EnvironmentObject var model: RestaurantModel
    init() {
        // Customize the tab bar for the whole app
        UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance.init(idiom: .unspecified)
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color("PlaceholderText"))
        UITabBar.appearance().barTintColor = UIColor(Color("PrimaryColor"))
    }
    
    var body: some View {
        if model.authorizationState == .notDetermined {
            HomeViewContent(isShowingMap: $isShowingMap, searchQuery: $searchQuery, tabSelection: $tabSelection)
                .onAppear() {
                    model.requestGeolocationPermission()
                }
        }
        // user allow access to location
        else if model.authorizationState == .authorizedAlways || model.authorizationState == .authorizedWhenInUse {
            
            HomeViewContent(isShowingMap: $isShowingMap, searchQuery: $searchQuery, tabSelection: $tabSelection)
                .onAppear() {
                    model.chooseDefaultLocation()
                    model.calculateDistanceRest()
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
                    print("Settings")
                }
        }
        
    }
    
}
