/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Tran Mai Nhung
 ID: s3879954
 Created  date: 07/08/2022
 Last modified: 07/08/2022
 Acknowledgement:
 - Canvas, CodeWithChris Course
 */

import SwiftUI

struct IngredientsView: View {
    let descArr: [String]
    
    var body: some View {
        // Display list of ingredients
        VStack(alignment: .leading) {
            ForEach(0..<descArr.count, id: \.self) { index in
                HStack {
                    Text("❃")
                        .font(.custom("Avenir", size: 20))
                    Text("\(descArr[index].capitalized)")
                        .font(.custom("Avenir", size: 17))
                }
            }
        }
    }
}

