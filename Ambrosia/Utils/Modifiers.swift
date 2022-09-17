//
//  Modifiers.swift
//  Ambrosia
//
//  Created by Khanh Tran Nguyen Ha on 10/09/2022.
//

import SwiftUI


struct TextFieldModifier: ViewModifier {
    @Environment(\.isFocused) private var isFocused: Bool

    func body(content: Content) -> some View {
        content
            .frame(minWidth: Constants.FIELD_MIN_WIDTH, maxWidth: Constants.FIELD_MAX_WIDTH, minHeight: Constants.FIELD_HEIGHT)
            .padding(.horizontal)
            .background(.thinMaterial)
            .foregroundColor(Constants.PRIMARY_COLOR)
            .cornerRadius(Constants.CONRNER_RADIUS)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .border(Color(uiColor: Constants.PRIMARY_COLOR_UI), width: isFocused ? 1 : 0)
    }
}

struct LightShadowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.5), radius: 3, x: -5, y: 5)
    }
}

struct CircularImageModifirer: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 93, height: 93)
            .clipShape(Circle())

    }
}


extension Circle {

    func circleBorderStyle(borderClr: String, borderWidth: CGFloat, circleWidth: CGFloat) -> some View {
        self
            .stroke(Color(borderClr), style: StrokeStyle(lineWidth: borderWidth, lineCap: .round))
            .frame(width: circleWidth, height: circleWidth, alignment: .center)
    }
    func trimCircleBorderStyle(checkConditionTrim: Bool, start: CGFloat, end: CGFloat, borderClr: String, borderWidth: CGFloat, circleWidth: CGFloat) -> some View {
        self
            .trim(from: checkConditionTrim ? 0.19 : 0, to: checkConditionTrim ? 0.89 : 1)
            .stroke(Color(borderClr), style: StrokeStyle(lineWidth: borderWidth, lineCap: .round))
            .frame(width: circleWidth, height: circleWidth, alignment: .center)
    }
}
