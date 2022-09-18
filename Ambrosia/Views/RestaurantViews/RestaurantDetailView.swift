/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 3
 Author: Nguyen Tuan Anh, Vo Quoc Huy, Tran Mai Nhung
 ID: s3864077, s3823236, s3879954
 Created  date: 09/09/2022
 Last modified: 17/09/2022
 Acknowledgement:
 - Canvas, CodeWithChris Course
 - https://stackoverflow.com/questions/59158476/how-to-have-text-in-shapes-in-swiftui
 - https://blckbirds.com/post/stretchy-header-and-parallax-scrolling-in-swiftui/
 - https://stackoverflow.com/questions/57582653/how-to-create-tappable-url-phone-number-in-swiftui
 */

import SwiftUI

struct RestaurantDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var userModel: UserModel
    @StateObject var firebaseService: FirebaseService = FirebaseService.services
    
    @EnvironmentObject var restaurantModel: RestaurantModel
    @State var showOpenningHours = false
    @State var showReview = false
    @State var clickFavourite = false
    @State var countFavourite = 0
    
    // MARK: back button when not in loading phase
    var btnBack: some View {
        Button(action: {
            // Sound effect
            SoundModel.clickOtherSound()
            
            self.presentationMode.wrappedValue.dismiss()
            // background music
            SoundModel.startBackgroundMusic(bckName: "home")
            
        }) {
            CircleButtonView(buttonImage: "arrow.left")
        }.buttonStyle(PlainButtonStyle())
    }
    
    // MARK: back button when in loading phase
    var btnBackProgress: some View {
        Button(action: {
            // Sound effect
            SoundModel.clickOtherSound()
            
            self.presentationMode.wrappedValue.dismiss()
            // background music
            SoundModel.startBackgroundMusic(bckName: "home")
        }) {
            HStack(spacing: 10) {
                ImageSystemHier(name: "chevron.backward", color: "PrimaryColor", size: 12)
                Text("Home")
                    .font(.system(size: 16))
                    .foregroundColor(Color("PrimaryColor"))
            }
            
        }.buttonStyle(PlainButtonStyle())
    }
    
    // MARK: favorite button to add restaurant to favorite
    var favouriteBtn: some View {
        Button(action: {
            SoundModel.clickCardSound()
            // change favorite when click
            clickFavourite = firebaseService.changeFavorites(userModel: userModel, restaurant: restaurantModel.currentRestaurant ?? Restaurant(placeId: ""))
            countFavourite += 1
        }, label: {
            CircleButtonView(buttonImage: "heart\(clickFavourite ? ".fill" : "")")
                .onAppear() {
                    clickFavourite = userModel.isRestaurantFavorite(restaurant: restaurantModel.currentRestaurant ?? Restaurant(placeId: "click favorite")) == nil ? false : true
                }
        })
        
    }
    
    var body: some View {
        if restaurantModel.currentRestaurant != nil {
            GeometryReader {
                geo in
                ScrollView{
                    // MARK: - restaurant image
                    RestaurantAsyncImage(photo_id: restaurantModel.currentRestaurant?.imageLink ?? "").frame(width: geo.size.width, height: geo.size.height/2.7)
                    
                    //MARK: - Rectange Restaurant Detail Card
                    VStack(spacing:20){
                        
                        ZStack {
                            // MARK: container
                            Rectangle().foregroundColor(Constants.CARD_BCK_COLOR).frame(width: geo.size.width - 30, height: geo.size.height / 4.5).cornerRadius(10).shadow(color: .black.opacity(0.5), radius: 5)
                            
                            // MARK: content
                            VStack(spacing: 5) {
                                // Open status
                                HStack {
                                    Text("⏰").font(.system(size: 12))
                                    Text(restaurantModel.currentRestaurant?.temporarilyClosed == false ? "OPEN" : "CLOSED").font(.system(size: 12)).foregroundColor(.red)
                                    
                                }
                                // Title
                                Text(restaurantModel.currentRestaurant?.title ?? "Mr.Sir - Mì Sir - Salad Sir - Sir nè").foregroundColor(Color("TextColor")).bold().font(.system(size: 30)).multilineTextAlignment(.center).frame(width: geo.size.width - 70).lineLimit(2)
                                // Distance and address
                                HStack {
                                    // distance
                                    Text("\(restaurantModel.currentRestaurant?.distance ?? 0, specifier: "%.1f") km").font(.system(size: 14)).foregroundColor(Color("SubTextColor")).bold()
                                    
                                    Text("•").foregroundColor(Color("SubTextColor"))
                                    
                                    // address
                                    Text(restaurantModel.currentRestaurant?.address ?? "Sir street, Sir city, Sir ngu").foregroundColor(Color("SubTextColor")).lineLimit(1).font(.system(size: 14))
                                    
                                }.frame(width:geo.size.width-100)
                                // Restaurant category
                                HStack{
                                    Text("Category: ").font(.system(size: 14)).foregroundColor(Color("SubTextColor"))
                                    Text("\(restaurantModel.currentRestaurant?.categoryName ?? "")").font(.system(size: 14)).foregroundColor(Color("SubTextColor")).bold()
                                }
                                
                            }.frame(width: geo.size.width - 30,height: geo.size.height / 4.5)
                        }
                        
                        // MARK: - Restaurant detail Vstack section
                        VStack(alignment: .leading) {
                            // MARK: open hours list
                            HStack {
                                // Icon
                                Image(systemName: "clock.circle").foregroundColor(Color("PrimaryColor"))
                                // Text
                                Text("Open Hours:  Monday-Sunday").font(.system(size: 14)).foregroundColor(Color("PrimaryColor"))
                                Spacer()
                                // See more to see open hours + map in sheet
                                Button {
                                    SoundModel.clickOtherSound()
                                    showOpenningHours = true
                                } label: {
                                    Text("See More").foregroundColor(Color("SecondaryColor")).font(.system(size: 14)).bold()
                                }.sheet(isPresented: $showOpenningHours) {
                                    OpeningHoursView()
                                }
                                
                            }
                            
                            Divider()
                            
                            // MARK: phone
                            HStack {
                                // Icon
                                Image(systemName: "phone.circle.fill").foregroundColor(Color("TextColor"))
                                // Text
                                Text("Phone number: \(restaurantModel.currentRestaurant?.phone ?? "No contact")").font(.system(size: 14)).foregroundColor(Color("TextColor"))
                                Spacer()
                                // Call button
                                Button {
                                    SoundModel.clickOtherSound()
                                    restaurantModel.callRest()
                                } label: {
                                    Text("Call").foregroundColor(Color("SecondaryColor")).font(.system(size: 14)).bold()
                                }
                            }
                            Divider()
                            
                            // MARK: review
                            HStack {
                                // icon
                                Image(systemName: "star.fill").foregroundColor(.yellow)
                                // rating score
                                Text("\(restaurantModel.currentRestaurant?.totalScore ?? 5.0, specifier: "%.1f")").font(.system(size: 14)).foregroundColor(Color("TextColor"))
                                // number of rating
                                Text("(\(restaurantModel.currentRestaurant?.reviewsCount ?? 5))").font(.system(size: 12)).foregroundColor(Color("SubTextColor")).offset(x: -5)
                                Spacer()
                                // add review/ view review view (in sheet)
                                Button {
                                    SoundModel.clickOtherSound()
                                    showReview.toggle()
                                } label: {
                                    Text("Read Reviews").foregroundColor(Color("SecondaryColor")).font(.system(size: 14)).bold()
                                    
                                }.sheet(isPresented: $showReview) {
                                    ReviewView()
                                    
                                }
                                
                                
                                
                            }
                            Divider()
                            
                            // MARK: Other options display
                            VStack(alignment: .leading) {
                                // service
                                if (restaurantModel.currentRestaurant?.serviceOptionsArr.count != 0){
                                    Breadcrumbs(options:"Service")
                                }
                                // dining
                                if (restaurantModel.currentRestaurant?.diningOptionsArr.count != 0){
                                    Breadcrumbs(options:"Dining")
                                }
                                // payment
                                if (restaurantModel.currentRestaurant?.paymentsArr.count != 0){
                                    Breadcrumbs(options:"Payment")
                                }
                                // planning
                                if (restaurantModel.currentRestaurant?.planingArr.count != 0){
                                    Breadcrumbs(options:"Planing")
                                }
                                
                            }
                            
                            Divider()
                            // MARK: display user rating in details
                            VStack(alignment:.leading){
                                Text("🎖 User Ratings:")
                                RatingContributionView(rating: Int(restaurantModel.currentRestaurant?.totalScore ?? 5.0))
                                
                            }
                            
                        }
                        
                    }.padding().offset(y:-100)
                        .background(Constants.BCK_COLOR)
                    
                    
                }
            }
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: btnBack, trailing: favouriteBtn)
        }
        else {
            // load if loading restaurant/ no restaurant
            ProgressView() {
                VStack {
                    GifView(name: "nothing").offset(y: 120)
                }
            }
            
            .progressViewStyle(CircularProgressViewStyle(tint: Color("PrimaryColor")))
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: btnBackProgress)
            
            .onAppear() {
                // favorite back home
                if(countFavourite != 0){
                    self.presentationMode.wrappedValue.dismiss()
                }
                SoundModel.startBackgroundMusic(bckName: "detail")
            }
        }
    }
    
    
    
    
}


//struct RestaurantDetailPreview: PreviewProvider {
//    static var previews: some View {
//        RestaurantDetailView()
//            .environmentObject(RestaurantModel())
//    }
//}
