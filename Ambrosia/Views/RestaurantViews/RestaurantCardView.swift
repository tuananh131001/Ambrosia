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
    var body: some View {
        
        HStack(){
            RestaurantAsyncImage(photo_id: photo_id).frame(width: 150, height: 150).cornerRadius(10)
            VStack(alignment:.leading,spacing:10){
                Text(name).foregroundColor(Color("TextColor")).bold().multilineTextAlignment(.leading).lineLimit(2).font(.system(size: 18))
                HStack{
                    Image(systemName:"star.fill").foregroundColor(Color("PrimaryColor"))
                    Text("\(rating,specifier: "%.1f")").font(.system(size: 14)).foregroundColor(Color("TextColor"))
                    Text("(\(total_ratings))").font(.system(size: 14)).foregroundColor(Color("TextColor")).offset(x:-5)
                    
                }
                HStack{
                    Image(systemName:"clock.circle").foregroundColor(Color("PrimaryColor"))
                    Text(status ? "Open" : "Closed").font(.system(size: 14)).foregroundColor(Color("TextColor"))
                    
                }
                HStack{
                    Image(systemName:"map.circle.fill").foregroundColor(Color("PrimaryColor"))
                    Text(address).multilineTextAlignment(.leading).lineLimit(2).font(.system(size: 14)).foregroundColor(Color("TextColor"))
                }
            }
            Spacer()

        }
        
        
        
    }
}

struct RestaurantCardView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantCardView(name: "Sir2fjdsnfkjsdnfjksadfnksdjfnsjkfsfjdkndsjkfnajkdfnajk13", rating: 4.2, status: true, address: "Sir street, Sir citsdfjnsdkfjnsafkjnsdfkjsdnfjkassdfnkjsadfnkajndfjksnfjkdsfy",photo_id: "AeJbb3d0ekH078McekC_3v4lVCjIoxH2QvIURkmLrEEdonPFjT_wFfx8GkOPax_FnNPN_VPM2BHtIjALJl2deLtNZdbqb1IBR66bgQClHCsAcR-Vp0DcYEaH8ZyWiiVly_P0rVqFl1uLc67FMR2hHlSq9-OXhyb5G5o1yqUujJNasT6w6IoK",total_ratings: 14)
        
    }
}
