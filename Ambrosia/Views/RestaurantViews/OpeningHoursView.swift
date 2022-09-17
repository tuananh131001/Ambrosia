//
//  OpeningHoursView.swift
//  Ambrosia
//
//  Created by Võ Quốc Huy on 12/09/2022.
//

import SwiftUI
import MapKit

struct OpeningHoursView: View {
    @EnvironmentObject var restaurantModel:RestaurantModel
    
    var body: some View {
        GeometryReader {
            geo in
            ScrollView{
                VStack(alignment:.leading,spacing:40){
                    Text(restaurantModel.currentRestaurant?.address ?? "Sir Street,Ward 3,Go Vap District,Sai Gon City").foregroundColor(Color("SubTextColor")).font(.system(size: 14)).padding(.horizontal)
                    HStack{
                        Spacer()
                        Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: restaurantModel.currentRestaurant?.location?.lat ?? 51.507222, longitude: restaurantModel.currentRestaurant?.location?.lng ?? -0.1275 ), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))),annotationItems: [
                            Point(coordinate: CLLocationCoordinate2D(latitude: restaurantModel.currentRestaurant?.location?.lat ?? 51.507222, longitude:restaurantModel.currentRestaurant?.location?.lng ?? -0.1275))
                            ]){
                                MapMarker(coordinate: $0.coordinate)
                        }
                        Spacer()
                    }.frame(width: geo.size.width, height: geo.size.height/3).aspectRatio(contentMode: .fill)
                    VStack(alignment:.leading,spacing:15){
                        Text("Openning Hours:").foregroundColor(Color("TextColor")).bold().font(.system(size: 16)).padding(.bottom,10)
                        ForEach(0..<(restaurantModel.currentRestaurant?.openingHours?.count ?? 0),id:\.self){
                            index in
                            HStack{
                                Text(restaurantModel.currentRestaurant?.openingHours?[index].day ?? "").foregroundColor(Color("SubTextColor")).font(.system(size: 15))
                                Text(restaurantModel.currentRestaurant?.openingHours?[index].hours ?? "").foregroundColor(Color("SubTextColor")).font(.system(size: 15))
                            }
                        
                        }
                    }.padding(.horizontal)
                }.padding(.vertical,40)
            }.frame(width:geo.size.width)
        }
    }
}

struct OpeningHoursView_Previews: PreviewProvider {
    static var previews: some View {
        OpeningHoursView().environmentObject(RestaurantModel())
    }
}
