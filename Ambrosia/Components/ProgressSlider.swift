/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 3
    Author: Vo Quoc Huy
    ID: s3823236
    Created  date: 16/09/2022
    Last modified: 17/09/2022
    Acknowledgement:
    - Canvas
*/

import SwiftUI

struct ProgressSlider: View {
    @EnvironmentObject var restaurantModel: RestaurantModel
    var number:Int
    @State private var value:CGFloat = 0
    var body: some View {
        HStack{
            Text("\(number)").foregroundColor(Color("PrimaryColor")).font(.system(size: 11))
            ZStack(alignment:.leading){
                Rectangle().frame(width:200,height:10).foregroundColor(Color("PlaceholderText")).cornerRadius(25)
                Rectangle().frame(width:value <= 0 ? 0 : value,height:10).foregroundColor(Color("PrimaryColor")).cornerRadius(25)
            }
        }
        .onAppear {
            value = restaurantModel.calculateNumber(number: number)
        }
    }
    

}

struct ProgressSlider_Previews: PreviewProvider {
    static var previews: some View {
        ProgressSlider(number: 5).environmentObject(RestaurantModel())
    }
}
