

import SwiftUI

struct FavouriteRestaurantView: View {
    @EnvironmentObject var model: RestaurantModel
    @EnvironmentObject var authModel: UserModel
    
    @State var rating: Int = 3
    @State var isOpen: Bool = false
    
    @State var imageSize: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                VStack {
                    ScrollView(.vertical) {
                        VStack {
                            ForEach(authModel.user.favouriteRestaurants, id: \.place_id) { r in
                                HStack {
                                    RestaurantAsyncImage(photo_id: r.photos?[0].photo_reference ?? "testRestaurant").frame(width: imageSize, height: imageSize).cornerRadius(10)
                                    VStack(alignment: .leading, spacing: 0) {
                                        HStack {
                                            Text("\(r.rating ?? 5.0, specifier: "%.1f")")
                                                .foregroundColor(Color("Fv Special Clr"))
                                            RatingView(rating: $rating, tappable: false, width: geo.size.width / 30, height: geo.size.width / 30)
                                        }
                                        Text(r.name)
                                            .lineLimit(1)
                                            .foregroundColor(Color("Fv Title Clr"))
                                        
                                        HStack {
                                            Image(systemName: "car.fill")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: geo.size.width / 35)
                                                .background(Color("Fv Subtitle Clr 2"))
                                            Text("\(r.distance, specifier: "%.2f")km")
                                                .foregroundColor(Color("Fv Subtitle Clr"))
                                            Text("\(model.type ?? "Inexpensive")")
                                                .foregroundColor(Color("Fv Subtitle Clr 2"))
                                        }
                                        
                                        Spacer()
                                        
                                        Text(isOpen ? "OPEN" : "CLOSED")
                                            .foregroundColor(Color("\(isOpen ? "Open" : "Close") Color"))
                                    }
                                    Spacer()
                                }
                                .onAppear() {
                                    rating = Int(r.rating ?? 0)
                                    model.getType(r.price_level)
                                    isOpen = r.opening_hours?.open_now ?? true
                                    
                                    imageSize = geo.size.width / 3
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
            .environmentObject(AuthenticationModel())
    }
}
