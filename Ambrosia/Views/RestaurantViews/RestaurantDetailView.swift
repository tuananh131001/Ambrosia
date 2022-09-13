/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Tran Mai Nhung
 ID: s3879954
 Created  date: 26/07/2022
 Last modified: 07/08/2022
 Acknowledgement:
 - Canvas, CodeWithChris Course
 - https://stackoverflow.com/questions/59158476/how-to-have-text-in-shapes-in-swiftui
 - https://blckbirds.com/post/stretchy-header-and-parallax-scrolling-in-swiftui/
 - https://stackoverflow.com/questions/57582653/how-to-create-tappable-url-phone-number-in-swiftui
 */

import SwiftUI

struct RestaurantDetailView: View {
 
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    
    @EnvironmentObject var restaurantModel: RestaurantModel
    @EnvironmentObject var userModel: UserModel
    @StateObject var firebaseService: FirebaseService = FirebaseService.services
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        HStack {
            CircleButtonView(buttonImage: "arrow.left")
            CircleButtonView(buttonImage: "heart").offset(x:260)
            
        }
    }.buttonStyle(PlainButtonStyle())
    }
    
    
//    ZStack {
//        // favorite
//        Button(action: {
//            clickFavourite = firebaseService.changeFavorites(userModel: userModel, restaurant: restaurantModel.currentRestaurant ?? Restaurant(place_id: ""))
//
//        }, label: {
//            Image(systemName: "heart\(clickFavourite ? "" : ".fill")")
//                .resizable()
//                .frame(width: 30, height: 30, alignment: .center)
//                .foregroundColor(.red)
//
//        })
//    }
//    .onAppear() {
//        clickFavourite = userModel.isRestaurantFavorite(restaurant: restaurantModel.currentRestaurant ?? Restaurant(place_id: "")) == nil ? false : true
//        print("Sir favorite click", userModel.isRestaurantFavorite(restaurant: restaurantModel.currentRestaurant ?? Restaurant(place_id: "")))
//    }
    var body: some View {
        if restaurantModel.restaurantDetail != nil {
            GeometryReader{
                geo in
                VStack{
                    if (restaurantModel.restaurantDetail?.photos?[0].photo_reference != "") {
                        RestaurantAsyncImage(photo_id: restaurantModel.restaurantDetail?.photos?[0].photo_reference ?? "").frame(width: geo.size.width, height: geo.size.height/2.3)
                    }
                    else {
                        Image("testRestaurants").resizable().aspectRatio(contentMode: .fill).frame(width: geo.size.width, height: geo.size.height/2.5).ignoresSafeArea()
                    }
                    VStack(alignment:.leading){
                        HStack{
                            Image(systemName:"clock.circle").foregroundColor(Color("PrimaryColor"))
                            Text("Open Hours:  Monday-Sunday").font(.system(size: 14)).foregroundColor(Color("PrimaryColor"))
                            Spacer()
                            Text("See More").foregroundColor(Color("SecondaryColor")).font(.system(size: 14)).bold()
                        
                        }
                        
                        
                        Divider()
                        HStack{
                            Image(systemName:"phone.circle.fill").foregroundColor(Color("TextColor"))
                            Text("Phone number: \(restaurantModel.restaurantDetail?.formatted_phone_number ?? "No contact")").font(.system(size: 14)).foregroundColor(Color("TextColor"))
                            Spacer()
                            Text("Call").foregroundColor(Color("SecondaryColor")).font(.system(size: 14)).bold()
                        }
                        Divider()
                        
                        HStack{
                            
                            Image(systemName:"star.fill").foregroundColor(.yellow)
                            Text("\(restaurantModel.restaurantDetail?.rating ?? 0,specifier: "%.1f")").font(.system(size: 14)).foregroundColor(Color("TextColor"))
                            Text("(\(restaurantModel.restaurantDetail?.user_ratings_total ?? 0 ))").font(.system(size: 12)).foregroundColor(Color("SubTextColor")).offset(x:-5)
                            Spacer()
                            NavigationLink(destination: {
                                Text("Hello")
                            }) {
                                Text("Read Reviews").foregroundColor(Color("SecondaryColor")).font(.system(size: 14)).bold()
                            }
                            
                        }
                        Divider()
                        
                        VStack(alignment:.leading){
                            Text("🎁 Special Services").foregroundColor(Color("PrimaryColor")).font(.system(size: 16))
                            Breadcrumbs().offset(y:-20)
                            
                        }
                        
                        
                    }.offset(y:100).padding()
                    
                    ZStack {
                        Rectangle().foregroundColor(.white).frame(width: geo.size.width-30, height: geo.size.height/4.5).cornerRadius(10).shadow(color: .black.opacity(0.5), radius: 5)
                        VStack(spacing:5){
                            HStack{
                                Image(systemName: "clock.fill").foregroundColor(Color("SecondaryColor"))
                                Text(restaurantModel.restaurantDetail?.opening_hours?.open_now ?? true ? "OPEN" : "Status: CLOSED").font(.system(size: 14)).foregroundColor(Color("SecondaryColor")).bold()
                                
                            }
                            Text(restaurantModel.restaurantDetail?.name ?? "Mr.Sir - Mì Sir - Salad Sir - Sir nè").foregroundColor(Color("TextColor")).bold().font(.system(size: 30)).multilineTextAlignment(.center).frame(width:geo.size.width-70).lineLimit(2)
                            HStack{
                                Text("\(restaurantModel.restaurantDetail?.distance ?? 0,specifier: "%.1f") km").font(.system(size: 14)).foregroundColor(Color("SubTextColor")).bold()
                                Text("•").foregroundColor(Color("SubTextColor"))
                                Text(restaurantModel.restaurantDetail?.formatted_address ?? "Sir street, Sir city, Sir ngu").foregroundColor(Color("SubTextColor")).lineLimit(1).font(.system(size: 14))
                                
                            }.frame(width:geo.size.width-100)
                            HStack{
                                Text("Price:").font(.system(size: 14)).foregroundColor(Color("SubTextColor"))
                                
                                Text(restaurantModel.type ?? "Inexpensive").font(.system(size: 14)).foregroundColor(Color("SubTextColor")).bold()
                            }
                            
                        }.frame(width: geo.size.width-30).padding()
                    }.offset(y:-400)
                    
                }
            }.ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: btnBack)
            
            
        }
        else{
            ProgressView()
        }
    }
    
    
    
}

//struct RestaurantDetailImage: View {
//    @State var imageScale = 1.0 // for changing cover image when scrolling
//    var rest: Restaurant
//    var body: some View {
//        GeometryReader { geo in
//            ZStack(alignment: .center) {
//                if geo.frame(in: .global).minY <= 0 {
//                    // scroll down outside the screen -> move image up
//                    RestaurantAsyncImage(photo_id: rest.photos?[0].photo_reference ?? "")
//                        .offset(y: geo.frame(in: .global).minY / 9) // move image up
//                    .clipped()
//
//                }
//                else {
//                    // scroll up -> increase image size + move image down
//                    RestaurantAsyncImage(photo_id: rest.photos?[0].photo_reference ?? "")
//                        .scaleEffect(1 + geo.frame(in: .global).minY / 500) // change scale of image
//                    .clipped()
//                        .offset(y: -geo.frame(in: .global).minY) // move image down
//                    .animation(.easeInOut.delay(2), value: imageScale)
//                }
//            }
//            // for fixing the text stand on the image bug
//            .frame(height: 600, alignment: .center)
//                .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.1), radius: 5, x: 3, y: 3)
//
//        }.frame(height: 603, alignment: .center)
//    }
//
//}


extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        //        let appearance = UINavigationBarAppearance()
        //        appearance.configureWithTransparentBackground()
        //        appearance.backgroundImage = UIImage(named: "testRestaurant")
        //        appearance.backgroundImageContentMode = .scaleAspectFill
        //
        //        let appearance2 = UINavigationBarAppearance()
        //
        //
        //        navigationBar.standardAppearance = appearance
        //        navigationBar.compactAppearance = appearance
        //        navigationBar.scrollEdgeAppearance = appearance
        
    }
}

struct RestaurantDetailPreview:PreviewProvider{
    static var previews: some View {
        RestaurantDetailView()
            .environmentObject(RestaurantModel())
    }
}
