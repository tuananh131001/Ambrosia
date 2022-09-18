/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 3
 Author: Vo Quoc Huy
 ID: s3823236
 Created  date: 11/09/2022
 Last modified: 17/09/2022
 Acknowledgement: Canvas, Github
 */
import SwiftUI



struct RestaurantListView: View {
    
    init () {
        // custom the ui navigation bar
        // custom large navigation title
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color("PrimaryColor")), .font: UIFont.systemFont(ofSize: 26)]
        // custom inline navigation title
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color("PrimaryColor")), .font: UIFont.systemFont(ofSize: 20)]
        // custom navigation background
        UINavigationBar.appearance().backgroundColor = UIColor.clear
        // custom navigation bar tint color
        UINavigationBar.appearance().barTintColor = UIColor(Color("ButtonTextColor"))
    }
    
    
    @EnvironmentObject var restaurantModel: RestaurantModel
    
    @State private var isTapped: Bool = false
    // function to return the restaurants array by the user input
    
    
    var body: some View {
        
        NavigationView {
            
            ScrollView {
                HStack{
                    DistrictFilterView()
                }
                HorizontalListView(sectionTitle: "Suggestion Restaurants", type: "suggestion")
                HorizontalListView(sectionTitle: "Nearby Restaurants", type: "nearby")
                VStack (alignment: .leading) {
                    HStack(alignment:.center){
                        Text("All Restaurants").bold().foregroundColor(Color("TextColor"))
                        Spacer()
                        NavigationLink () {
                            VerticalListView(type: "all")
                        } label: {
                            Text("See More").foregroundColor(Color("SecondaryColor"))
                        }
                    }.padding()
                    
                    
                    // scroll view to show all the restaurants
                    LazyVStack(alignment:.trailing,spacing: 35) {
                        ForEach(0..<restaurantModel.firstTwentyRestaurants.count, id: \.self) {
                            index in
                            // link to the restaurant detail
                            NavigationLink(tag: index, selection: $restaurantModel.restaurantSelected) {
                                // find the current restaurant and display when the view appear
                                RestaurantDetailView().onAppear {
                                    restaurantModel.getCurrentRestaurant(placeId: restaurantModel.firstTwentyRestaurants[index].placeId ?? "")
                                    restaurantModel.getServiceOptions()
                                    restaurantModel.getDiningOptions()
                                    restaurantModel.getPlaningOptions()
                                    restaurantModel.getPaymentOptions()
                                }
                                
                            } label: {
                                // Card to show restaurant
                                RestaurantCardView(name: restaurantModel.firstTwentyRestaurants[index].title, rating: restaurantModel.firstTwentyRestaurants[index].totalScore ?? 5.0, address: restaurantModel.firstTwentyRestaurants[index].address ?? "", photo_id: restaurantModel.firstTwentyRestaurants[index].imageLink, total_ratings: restaurantModel.firstTwentyRestaurants[index].reviewsCount ?? 5, distance: restaurantModel.firstTwentyRestaurants[index].distance)
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                SoundModel.clickCardSound()
                            })
                            
                        }
                     
                        // add the search bar and set the mode to always display the search bar
                    }.navigationTitle("Ambrosia").accentColor(Color("PrimaryColor")).padding()
                }
                
                
            } .onChange(of: restaurantModel.restaurantSelected) { newValue in
                if (newValue ==
                    nil) {
                    restaurantModel.currentRestaurant = nil
                }
            }
            .background(Constants.BCK_COLOR)
        }.navigationViewStyle(StackNavigationViewStyle())
        
        
        
    }
}


struct RestaurantListView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantListView()
            .environmentObject(RestaurantModel())
    }
}
