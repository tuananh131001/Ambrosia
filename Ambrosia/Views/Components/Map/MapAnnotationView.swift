/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Tran Mai Nhung
 ID: s3879954
 Created  date: 04/08/2022
 Last modified: 07/08/2022
 Acknowledgement:
 - Canvas, CodeWithChris Course
 */

import SwiftUI

struct MapAnnotationView: View {
    @EnvironmentObject var model: RestaurantModel
    @State var isShowing = false
    var rest: Restaurant
    var showMap: () -> Void
    var body: some View {
        VStack(spacing: 10) {
            // MARK: card showed after tapping
            ZStack {
                Rectangle()
                    .foregroundColor(.white)
                VStack {
                    // Restaurant name
                    Text(rest.name)
                        .lineLimit(1)
                        .font(.title2)
                        .frame(width: 120)
                        .foregroundColor(Color("RestDetailTitleColor"))
                    
                    // click here to open route
                    HStack {
                        Text(rest.address)
                            .lineLimit(1)
                            .font(.headline)
                            .frame(width: 120)
                        Spacer()
                        Image(systemName: "location.fill.viewfinder")
                            .font(.title3)
                        
                    }
                }
                
                .foregroundColor(.black)
                .padding(7)
                .onTapGesture {
                    // open route in apple map
                    isShowing = false
                    showMap()
                }
            }
            .cornerRadius(10)
            .opacity(isShowing ? 1 : 0)
            
            // MARK: the marker
            Image("marker")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .onTapGesture {
                    isShowing.toggle()
                }
        }
    }
}
