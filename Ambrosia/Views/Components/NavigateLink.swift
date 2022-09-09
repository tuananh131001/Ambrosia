//
//  RestaurantLinkView.swift
/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Tran Mai Nhung
 ID: s3879954
 Created  date: 31/07/2022
 Last modified: 07/08/2022
 Acknowledgement:
 - Canvas, CodeWithChris Course
 */

import SwiftUI

struct NavigateLink: View {
    // Reusable view for HomeView - Search function
    var destinationView: AnyView
    var labelView: AnyView
    var navigateMethod: () -> Void
    var body: some View {
        NavigationLink(destination: {
            destinationView
                .onAppear() {
                    navigateMethod()
                }
        }, label: {
            // MARK: restaurant basic card
            labelView
        })
    }
}
