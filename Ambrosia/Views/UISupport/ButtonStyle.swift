//
//  ButtonStyle.swift
//  Ambrosia
//
//  Created by Khanh Tran Nguyen Ha on 10/09/2022.
//

import SwiftUI

struct ButtonStyle1: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: Constants.FIELD_MIN_WIDTH, maxWidth: Constants.FIELD_MAX_WIDTH)
            .padding()
            .background(.thinMaterial)
//            .clipShape(Capsule())
            .cornerRadius(Constants.CONRNER_RADIUS)
            .shadow(color: Color("Shadow"), radius: 5.0, x: 2, y: 2)
            .scaleEffect(configuration.isPressed ? 1.1 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
