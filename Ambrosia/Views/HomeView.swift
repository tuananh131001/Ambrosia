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
    @EnvironmentObject var viewModel: AuthenticationModel

    var body: some View {
        VStack {
            NavigationView {
                RestaurantList()
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
    }

    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
                .environmentObject(RestaurantModel())
                .environmentObject(AuthenticationModel())
        }
    }
}
