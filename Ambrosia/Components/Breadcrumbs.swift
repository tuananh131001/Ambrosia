//
//  BreadCrumbs.swift
//  Ambrosia
//
//  Created by Võ Quốc Huy on 12/09/2022.
//

import SwiftUI

struct Breadcrumbs: View {
    @EnvironmentObject var restaurantModel: RestaurantModel
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 20) {
                ForEach(0..<(restaurantModel.restaurantDetail?.options.count ?? 0),id: \.self) {
                    index in

                    HStack{
                        if (restaurantModel.restaurantDetail?.options[index] == "Dine in"){
                            Text("🍔").font(.system(size: 14)).padding([.top,.bottom],7).padding(.leading,17)
                        }
                        else if (restaurantModel.restaurantDetail?.options[index] == "Delivery"){
                            Text("🛵").font(.system(size: 14)).padding([.top,.bottom],7).padding(.leading,17)
                        }
                        else if (restaurantModel.restaurantDetail?.options[index] == "Take out"){
                            Text("🍱").font(.system(size: 14)).padding([.top,.bottom],7).padding(.leading,17)
                        }
                        else if (restaurantModel.restaurantDetail?.options[index] == "Serves wine"){
                            Text("🍷").font(.system(size: 14)).padding([.top,.bottom],7).padding(.leading,17)
                        }


                        Text(restaurantModel.restaurantDetail?.options[index] ?? "").foregroundColor(Color("SubTextColor")).bold().font(.system(size: 14)).padding([.top,.bottom],7).padding(.trailing,17)
                    }.background(Color("SubTextColor").opacity(0.18))
                        .cornerRadius(20)



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
        Breadcrumbs()
            .environmentObject(RestaurantModel())
    }
}
