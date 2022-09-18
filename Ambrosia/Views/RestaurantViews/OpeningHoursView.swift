/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 3
 Author: Vo Quoc Huy
 ID: s3823236
 Created  date: 12/09/2022
 Last modified: 17/09/2022
 Acknowledgement:
 - Canvas
 */

import SwiftUI
import MapKit

struct OpeningHoursView: View {
    @EnvironmentObject var restaurantModel:RestaurantModel
    
    var body: some View {
        GeometryReader {
            geo in
            ScrollView{
                VStack(alignment:.leading,spacing:40){
                    // MARK: address
                    Text(restaurantModel.currentRestaurant?.address ?? "Sir Street,Ward 3,Go Vap District,Sai Gon City").foregroundColor(Color("SubTextColor")).font(.system(size: 14)).padding(.horizontal)
                    
                    // MARK: map display
                    HStack{
                        Spacer()
                        Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: restaurantModel.currentRestaurant?.location?.lat ?? 51.507222, longitude: restaurantModel.currentRestaurant?.location?.lng ?? -0.1275 ), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))),annotationItems: [
                            Point(coordinate: CLLocationCoordinate2D(latitude: restaurantModel.currentRestaurant?.location?.lat ?? 51.507222, longitude:restaurantModel.currentRestaurant?.location?.lng ?? -0.1275))
                        ]){
                            MapMarker(coordinate: $0.coordinate)
                        }
                        Spacer()
                    }.frame(width: geo.size.width, height: geo.size.height/3).aspectRatio(contentMode: .fill)
                    
                    // MARK: opening hours list
                    VStack(alignment:.leading,spacing:15){
                        Text("Openning Hours:").foregroundColor(Color("TextColor")).bold().font(.system(size: 16)).padding(.bottom,10)
                        ForEach(0..<(restaurantModel.currentRestaurant?.openingHours?.count ?? 0),id:\.self){
                            index in
                            HStack{
                                // date
                                Text(restaurantModel.currentRestaurant?.openingHours?[index].day ?? "").foregroundColor(Color("SubTextColor")).font(.system(size: 15))
                                // time
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
