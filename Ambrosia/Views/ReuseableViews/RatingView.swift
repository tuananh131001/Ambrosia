/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Tran Mai Nhung
 ID: s3879954
 Created  date: 29/07/2022
 Last modified: 07/08/2022
 Acknowledgement:
 - Canvas, CodeWithChris Course
 */

import SwiftUI

struct RatingView: View {
    // Display ratings
    var rest: Restaurant
    var iconFontSize = Font.headline
    var fontSize = Font.headline
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
                .font(iconFontSize)
            Text("\(String(rest.rating))")
                .foregroundColor(Color("RestCardCaptColor"))
                .font(fontSize)
        }
    }
}
