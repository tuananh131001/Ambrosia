//
//  FavoriteButton.swift
//  Ambrosia
//
//  Created by Nhung Tran on 16/09/2022.
// https://stackoverflow.com/questions/59682446/how-to-trigger-action-after-x-seconds-in-swiftui

import SwiftUI

struct FavoriteButton: View {
    @EnvironmentObject var userModel: UserModel
    @StateObject var firebaseService: FirebaseService = FirebaseService.services
    

    @State private var offset = CGSize.zero
    @State private var isDragging = false
    @GestureState var isTapping = false
    var rest: Restaurant
    @State var isClick: Bool = true
    @State var calcTimes: Int = 0
    
    var body: some View {

        // Gets triggered immediately because a drag of 0 distance starts already when touching down.
        let tapGesture = DragGesture(minimumDistance: 0)
            .updating($isTapping) { _, isTapping, _ in
            isTapping = true
        }

        // minimumDistance here is mainly relevant to change to red before the drag
        let dragGesture = DragGesture(minimumDistance: 0)
            .onChanged { offset = $0.translation }
            .onEnded { _ in
            withAnimation {
                offset = .zero
                isDragging = false
            }
        }

        let pressGesture = LongPressGesture(minimumDuration: 1.0)
            .onEnded { value in
            withAnimation {
                isDragging = true
            }
        }

        // The dragGesture will wait until the pressGesture has triggered after minimumDuration 1.0 seconds.
        let combined = pressGesture.sequenced(before: dragGesture)

        // The new combined gesture is set to run together with the tapGesture.
        let simultaneously = tapGesture.simultaneously(with: combined)

        return ImageSystemHier(name: "heart\(isClick ? ".fill" : "")", color: "Close Color", size: 30)
//            .overlay(isTapping ? Circle().stroke(Color.red, lineWidth: 5) : nil) //listening to the isTapping state
            .foregroundColor(isDragging ? Color.red : Color.black) // listening to the isDragging state.
            .offset(offset)
            .gesture(simultaneously)
            .onChange(of: isTapping) { newValue in
                calcTimes += 1
                if calcTimes % 2 != 0 {
                    // remove
                    isClick = firebaseService.changeFavorites(userModel: userModel, restaurant: rest)
                }
            }

    }
}
