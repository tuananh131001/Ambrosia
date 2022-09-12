//
//  CircleButtonView.swift
//  Ambrosia
//
//  Created by Võ Quốc Huy on 10/09/2022.
//

import SwiftUI

struct CircleButtonView: View {
    var buttonImage:String
    var body: some View {
        ZStack{
            Rectangle().frame(width: 40, height: 40).foregroundColor(Color("PrimaryColor")).clipShape(Circle())
            Image(systemName: buttonImage).resizable().frame(width: 20, height: 20).aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
            
        }
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonView(buttonImage: "square.and.pencil")
    }
}
