

import SwiftUI

struct FavouriteRestaurantView: View {
    @EnvironmentObject var model: RestaurantModel
    @EnvironmentObject var authModel: UserModel
    
    @State var rating: Int = 3
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                VStack {
                    ScrollView(.vertical) {
                        VStack {
                            ForEach(authModel.user.favouriteRestaurants, id: \.place_id) { r in
                                HStack {
                                    RestaurantAsyncImage(photo_id: r.photos?[0].photo_reference ?? "testRestaurant").frame(width: geo.size.width / 3, height: geo.size.width / 3).cornerRadius(10)
                                    VStack(alignment: .leading) {
                                        RatingView(rating: $rating, tappable: false, width: geo.size.width / 20, height: geo.size.width / 20)
                                        Text(r.name)
                                            .lineLimit(1)
                                        
                                        HStack {
                                            Image(systemName: "mappin.and.ellipse")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: geo.size.width / 25)
                                            Text(r.vicinity ?? "Address Unupdated")
                                        }
                                        
                                        
                                        Spacer()
                                    }
                                    Spacer()
                                }
                                .onAppear() {
                                    rating = Int(r.rating ?? 0)
                                    print(r)
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

struct FavouriteRestaurantView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteRestaurantView()
            .environmentObject(RestaurantModel())
    }
}
