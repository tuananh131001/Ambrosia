/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 3
    Author: Tran Mai Nhung
    ID: s3879954
    Created  date: 17/09/2022
    Last modified: 17/09/2022
    Acknowledgement:
    - Canvas, CodeWithChris Course
*/

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
