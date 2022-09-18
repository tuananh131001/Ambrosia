//
//  BreadCrumbs.swift
//  Ambrosia
//
//  Created by Võ Quốc Huy on 12/09/2022.
//

import SwiftUI

struct Breadcrumbs: View {
    @EnvironmentObject var restaurantModel: RestaurantModel
    var options:String
    var body: some View {
        VStack (alignment:.leading,spacing:15){
            HStack{
                ImageSystemHier(name: "checkmark.seal", color: "PrimaryColor", size: 16)
                Text("\(options) Options").foregroundColor(Color("TextColor")).font(.system(size: 16))

            }

            ScrollView(.horizontal, showsIndicators:false) {
                LazyHStack(spacing: 20) {
                    if options == "Service"{
                        ForEach(0..<(restaurantModel.currentRestaurant?.serviceOptionsArr.count ?? 0),id: \.self) {
                            index in
                            HStack{
                                if (restaurantModel.currentRestaurant?.serviceOptionsArr[index] == "Dine in"){
                                    Text("🍔").font(.system(size: 14)).padding([.top,.bottom],7).padding(.leading,17)
                                }
                                else if (restaurantModel.currentRestaurant?.serviceOptionsArr[index] == "Delivery"){
                                    Text("🛵").font(.system(size: 14)).padding([.top,.bottom],7).padding(.leading,17)
                                }
                                else if (restaurantModel.currentRestaurant?.serviceOptionsArr[index] == "Take out"){
                                    Text("🍱").font(.system(size: 14)).padding([.top,.bottom],7).padding(.leading,17)
                                }
                                Text(restaurantModel.currentRestaurant?.serviceOptionsArr[index] ?? "").foregroundColor(Color("SubTextColor")).bold().font(.system(size: 14)).padding([.top,.bottom],7).padding(.trailing,17)
                            }.background(Color("SubTextColor").opacity(0.18))
                                .cornerRadius(20)

                        }
                    }
                    if options == "Dining"{
                        ForEach(0..<(restaurantModel.currentRestaurant?.diningOptionsArr.count ?? 0),id: \.self) {
                            index in
                            HStack{
                                if (restaurantModel.currentRestaurant?.diningOptionsArr[index] == "Lunch"){
                                    Text("🥗").font(.system(size: 14)).padding([.top,.bottom],7).padding(.leading,17)
                                }
                                else if (restaurantModel.currentRestaurant?.diningOptionsArr[index] == "Dinner"){
                                    Text("🍕").font(.system(size: 14)).padding([.top,.bottom],7).padding(.leading,17)
                                }
                                else if (restaurantModel.currentRestaurant?.diningOptionsArr[index] == "Dessert"){
                                    Text("🍰").font(.system(size: 14)).padding([.top,.bottom],7).padding(.leading,17)
                                }
                                else if (restaurantModel.currentRestaurant?.diningOptionsArr[index] == "Breakfast"){
                                    Text("🍞").font(.system(size: 14)).padding([.top,.bottom],7).padding(.leading,17)
                                }
                                Text(restaurantModel.currentRestaurant?.diningOptionsArr[index] ?? "").foregroundColor(Color("SubTextColor")).bold().font(.system(size: 14)).padding([.top,.bottom],7).padding(.trailing,17)
                            }.background(Color("SubTextColor").opacity(0.18))
                                .cornerRadius(20)

                        }
                    }
                    if options == "Payment"{
                        ForEach(0..<(restaurantModel.currentRestaurant?.paymentsArr.count ?? 0),id: \.self) {
                            index in
                            HStack{
                                if (restaurantModel.currentRestaurant?.paymentsArr[index] == "Cash Only"){
                                    Text("💵").font(.system(size: 14)).padding([.top,.bottom],7).padding(.leading,17)
                                }
                                else if (restaurantModel.currentRestaurant?.paymentsArr[index] == "Credit Cards"){
                                    Text("🏧").font(.system(size: 14)).padding([.top,.bottom],7).padding(.leading,17)
                                }
                                else if (restaurantModel.currentRestaurant?.paymentsArr[index] == "Debit Cards"){
                                    Text("💳").font(.system(size: 14)).padding([.top,.bottom],7).padding(.leading,17)
                                }
                                Text(restaurantModel.currentRestaurant?.paymentsArr[index] ?? "").foregroundColor(Color("SubTextColor")).bold().font(.system(size: 14)).padding([.top,.bottom],7).padding(.trailing,17)
                            }.background(Color("SubTextColor").opacity(0.18))
                                .cornerRadius(20)

                        }
                    }
                    if options == "Planing"{
                        ForEach(0..<(restaurantModel.currentRestaurant?.planingArr.count ?? 0),id: \.self) {
                            index in
                            HStack{
                                if (restaurantModel.currentRestaurant?.planingArr[index] == "Accept Reservations"){
                                    Text("🚖").font(.system(size: 14)).padding([.top,.bottom],7).padding(.leading,17)
                                }
                                else if (restaurantModel.currentRestaurant?.planingArr[index] == "Reservation Required"){
                                    Text("🚘").font(.system(size: 14)).padding([.top,.bottom],7).padding(.leading,17)
                                }
                                Text(restaurantModel.currentRestaurant?.planingArr[index] ?? "").foregroundColor(Color("SubTextColor")).bold().font(.system(size: 14)).padding([.top,.bottom],7).padding(.trailing,17)
                            }.background(Color("SubTextColor").opacity(0.18))
                                .cornerRadius(20)

                        }
                    }

                }
            }
        }
//        HStack{
//
//            Text("🍔").font(.system(size: 14)).padding([.top,.bottom],7).padding(.leading,17)
//
//
//
//
//            Text("Dine in").foregroundColor(Color("SubTextColor")).bold().font(.system(size: 14)).padding([.top,.bottom],7).padding(.trailing,17)
//        }.background(Color("SubTextColor").opacity(0.18))
//            .cornerRadius(20)
    }
    
}

struct BreadCrumbs_Previews: PreviewProvider {
    static var previews: some View {
        Breadcrumbs(options: "Service")
            .environmentObject(RestaurantModel())
    }
}
