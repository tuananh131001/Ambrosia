/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 3
 Author: Tran Mai Nhung
 ID: s3879954
 Created  date: 9/09/2022
 Last modified: 17/09/2022
 Acknowledgement:
 - Canvas, CodeWithChris Course
 */

import SwiftUI

struct NotFoundView: View {
    // Use this where there is no restaurant found
    var message: String = "Oops Cannot Found The Result"
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Image("404 Not Found")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200)
            Text(.init(message))
                .font(.title3)
                .bold()
                .foregroundColor(Color("NotFoundColor"))
                .multilineTextAlignment(.center)
            Spacer()
            
        }
        .opacity(0.5)
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .center)
    }
}
