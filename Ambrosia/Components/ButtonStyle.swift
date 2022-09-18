/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 3
    Author: Tran Nguyen Ha Khanh
    ID: s3877707
    Created  date: 10/09/2022
    Last modified: 17/09/2022
    Acknowledgement:
    - Canvas
*/

import SwiftUI

// reusable button styles
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


