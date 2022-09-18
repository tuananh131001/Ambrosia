/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 3
    Author: Tran Mai Nhung
    ID: s3879954
    Created  date: 14/09/2022
    Last modified: 14/09/2022
    Acknowledgement:
    - Canvas
*/

import SwiftUI

struct GeneralBackground: View {
    var body: some View {
        ZStack {
            Color("Splash BckClr")
            BackgroundImage()
                .opacity(0.25)
        }
    }
}

struct GeneralBackground_Previews: PreviewProvider {
    static var previews: some View {
        GeneralBackground()
    }
}
