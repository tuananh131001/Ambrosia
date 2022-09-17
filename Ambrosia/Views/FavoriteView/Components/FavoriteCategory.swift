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

struct FavoriteCategory: View {
    var rest: Restaurant
    var body: some View {
        Text(rest.categoryName?.capitalized ?? "Restaurant")
            .foregroundColor(Constants.PRIMARY_COLOR)
            .font(.subheadline)

    }
}
