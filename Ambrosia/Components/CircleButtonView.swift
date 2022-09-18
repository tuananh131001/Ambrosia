/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 3
    Author: Vo Quoc Huy
    ID: s3823236
    Created  date: 10/09/2022
    Last modified: 17/09/2022
    Acknowledgement:
    - Canvas
*/

import SwiftUI

struct CircleButtonView: View {
    var buttonImage:String
    var color: Color = Color.white
    var body: some View {
        ZStack{
            Rectangle().frame(width: 40, height: 40).foregroundColor(Color("PrimaryColor")).clipShape(Circle())
            Image(systemName: buttonImage)
                .resizable()
                .frame(width: 20, height: 20)
                .aspectRatio(contentMode: .fit)
                .foregroundColor(color)
            
        }
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonView(buttonImage: "square.and.pencil")
    }
}
