//
//  RestaurantCardView.swift
//  Ambrosia
//
//  Created by Võ Quốc Huy on 11/09/2022.
//

import SwiftUI

struct RestaurantCardView: View {
    var name:String
    var rating:Double
    var status:Bool
    var address:String
    var photo_id:String
    var total_ratings:Int
    var distance:Double
    
    @EnvironmentObject var restaurantModel: RestaurantModel
    @EnvironmentObject var userModel: UserModel
    
    @StateObject var firebaseService = FirebaseService.services
    
    var body: some View {
        VStack(spacing:10){
            HStack(spacing:15){
                RestaurantAsyncImage(photo_id: photo_id).frame(width: 100, height: 100).cornerRadius(10)
                VStack(alignment:.leading,spacing:10){
                    Spacer()
                    HStack{
                        Image(systemName: "checkmark.seal.fill").foregroundColor(Color("SecondaryColor"))
                        Text(name).foregroundColor(Color("TextColor")).bold().multilineTextAlignment(.leading).lineLimit(2).font(.system(size: 18)).offset(x:-5)
                    }
                  
                    HStack{
                        Text(address).multilineTextAlignment(.leading).lineLimit(2).font(.system(size: 14)).foregroundColor(Color("SubTextColor"))
                    }
                    Spacer()
                    HStack(spacing:2){
                        Image(systemName:"star.fill").foregroundColor(Color("PrimaryColor"))
                        Text("\(rating,specifier: "%.1f")").font(.system(size: 14)).foregroundColor(Color("TextColor"))
                        Text("(\(total_ratings))").font(.system(size: 12)).foregroundColor(Color("SubTextColor")).offset(x:-1)
                        Text("•").foregroundColor(Color("SubTextColor"))
                            Text("\(distance,specifier: "%.1f") km").font(.system(size: 14)).foregroundColor(Color("SubTextColor"))
                        
                    }
                    Spacer()
                }.frame(height: 100)
                Spacer()

            }
            Divider()
        }
        
        
        
    }
}

struct RestaurantCardView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantCardView(name: "Mì Sinh Đôi", rating: 4.2, status: true, address: "70 Nguyễn Văn linh, Ward 3, District Go Vap",photo_id: "AeJbb3d0ekH078McekC_3v4lVCjIoxH2QvIURkmLrEEdonPFjT_wFfx8GkOPax_FnNPN_VPM2BHtIjALJl2deLtNZdbqb1IBR66bgQClHCsAcR-Vp0DcYEaH8ZyWiiVly_P0rVqFl1uLc67FMR2hHlSq9-OXhyb5G5o1yqUujJNasT6w6IoK",total_ratings: 14,distance: 0.5)
        
    }
}
