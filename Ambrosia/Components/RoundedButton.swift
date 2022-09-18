/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 3
 Author: Vo Quoc Huy
 ID: s3823236
 Created  date: 11/09/2022
 Last modified: 13/09/2022
 Acknowledgement:
 - Canvas
 */

import SwiftUI

struct RoundedButton: View {
    // reusable button with corner radius (round rectangle)
    var buttonText:String
    var width:CGFloat
    var height:CGFloat
    var size:CGFloat
    var body: some View {
        ZStack{
            Rectangle().frame(width: width, height: height).foregroundColor(Color("PrimaryColor"))   .clipShape(RoundedRectangle(cornerRadius: 10))
            Text(buttonText).foregroundColor(Color("ButtonTextColor")).bold().font(.system(size: size))
        }
        
    }
}

struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundedButton(buttonText: "Submit",width: 400,height: 60,size:16)
    }
}
