//
//  RoundedButton.swift
//  Ambrosia
//
//  Created by Võ Quốc Huy on 11/09/2022.
//

import SwiftUI

struct RoundedButton: View {
    var buttonText:String
    var width:CGFloat
    var height:CGFloat
    var body: some View {
        ZStack{
            Rectangle().frame(width: width, height: height).foregroundColor(Color("PrimaryColor")).clipShape(RoundedRectangle(cornerRadius: 10))
            Text(buttonText).foregroundColor(Color("ButtonTextColor")).bold()
        }

    }
}

struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundedButton(buttonText: "Submit",width: 400,height: 60)
    }
}
