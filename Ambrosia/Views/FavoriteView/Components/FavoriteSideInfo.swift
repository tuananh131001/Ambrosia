/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 3
    Author: Tran Mai Nhung
    ID: s3879954
    Created  date: 16/09/2022
    Last modified: 17/09/2022
    Acknowledgement:
    - Canvas
*/

import SwiftUI

struct FavoriteSideInfo: View {
    var rest: Restaurant

    var body: some View {
        HStack {

            
            // MARK: distance
            Label {
                Text("\(rest.distance, specifier: "%.2f")km")
            } icon: {
                Image(systemName: "car.fill")
            }
            .foregroundColor(Color("SubTextColor"))

        }
        .lineLimit(1)
        .font(.subheadline)
    }
}
