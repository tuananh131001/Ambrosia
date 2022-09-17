//
//  FavoriteNotFound.swift
//  Ambrosia
//
//  Created by Nhung Tran on 17/09/2022.
//

import SwiftUI

struct FavoriteNotFound: View {
    var geo: GeometryProxy
    var body: some View {
        VStack(spacing: 6) {
            Spacer()
            
            GifView(name: "boring-cat")
                .frame(width: geo.size.width, height: 250)
            Text("Hmmm....")
                .bold()
            Text("You have no favorite yet".capitalized)
                .bold()
            Spacer()
        }
        .font(.title2)
        .foregroundColor(Constants.SECONDARY_COLOR)
    }
}
