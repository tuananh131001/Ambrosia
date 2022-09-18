/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 3
    Author: Tran Mai Nhung
    ID: s3879954
    Created  date: 14/09/2022
    Last modified: 15/09/2022
    Acknowledgement:
    - Canvas
*/

import SwiftUI

struct ImageSystemHier: View {
    let name: String
    let color: String
    let size: CGFloat
    
    var body: some View {
        Image(systemName: name)
            .resizable()
            .scaledToFit()
            .symbolRenderingMode(.hierarchical)
            .foregroundStyle(Color(color))
            .frame(width: size, height: size)
    }
}
