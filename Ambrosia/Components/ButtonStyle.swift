//
//  ButtonStyle.swift
//  Ambrosia
//
//  Created by Khanh Tran Nguyen Ha on 10/09/2022.
//

import SwiftUI

struct ButtonStylePrimary: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: Constants.FIELD_MIN_WIDTH, maxWidth: Constants.FIELD_MAX_WIDTH, minHeight: Constants.FIELD_HEIGHT)
            .padding(.horizontal)
            .background(Constants.PRIMARY_COLOR)
            .foregroundColor(.white)
            .cornerRadius(Constants.CONRNER_RADIUS)
            .scaleEffect(configuration.isPressed ? 1.1 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct ButtonStyleLightPrimary: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: Constants.FIELD_MIN_WIDTH, maxWidth: Constants.FIELD_MAX_WIDTH, minHeight: Constants.FIELD_HEIGHT)
            .padding(.horizontal)
            .background(Constants.LIGH_PRIMARY_COLOR)
            .foregroundColor(.white)
            .cornerRadius(Constants.CONRNER_RADIUS)
            .scaleEffect(configuration.isPressed ? 1.1 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}


struct ButtonStyleWhite: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: Constants.FIELD_MIN_WIDTH, maxWidth: Constants.FIELD_MAX_WIDTH, minHeight: Constants.FIELD_HEIGHT)
            .padding(.horizontal)
            .background(Color("ButtonTextColor"))
            .foregroundColor(Constants.PRIMARY_COLOR)
            .cornerRadius(Constants.CONRNER_RADIUS)
            .scaleEffect(configuration.isPressed ? 1.1 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct ButtonStyleWhiteLight: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: Constants.FIELD_MIN_WIDTH, maxWidth: Constants.FIELD_MAX_WIDTH, minHeight: Constants.FIELD_HEIGHT)
            .padding(.horizontal)
            .background(.white)
            .foregroundColor(Constants.LIGH_PRIMARY_COLOR)
            .cornerRadius(Constants.CONRNER_RADIUS)
            .scaleEffect(configuration.isPressed ? 1.1 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}


