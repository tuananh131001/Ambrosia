/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 3
 Author: Nguyen Tuan Anh, Vo Quoc Huy, Tran Nguyen Ha Khanh, Tran Mai Nhung
 ID: s3864077, s3823236, s3877707, s3879954
 Created  date: 6/09/2022
 Last modified: 15/09/2022
 Acknowledgement:
 - Canvas
 */

import SwiftUI

// MARK: reusable styling text field
struct TextFieldModifier: ViewModifier {
    @Environment(\.isFocused) private var isFocused: Bool
    
    func body(content: Content) -> some View {
        content
            .frame(minWidth: Constants.FIELD_MIN_WIDTH, maxWidth: Constants.FIELD_MAX_WIDTH, minHeight: Constants.FIELD_HEIGHT)
            .padding(.horizontal)
            .background(.thinMaterial)
            .foregroundColor(Constants.PRIMARY_COLOR_TEXT_FIELD_COLOR)
            .cornerRadius(Constants.CONRNER_RADIUS)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .border(Color(uiColor: Constants.PRIMARY_COLOR_UI), width: isFocused ? 1 : 0)
    }
}

// MARK: reusable styling shadow
// light shadow (small radius)
struct LightShadowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.5), radius: 3, x: -5, y: 5)
    }
}
// normal shadow (high radius)
struct NormalShadowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.5), radius: 7, x: -5, y: 5)
    }
}

// MARK: reuasble image as cicle
struct CircularImageModifirer: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 93, height: 93)
            .clipShape(Circle())
        
    }
}

// MARK: styling cirlce shape
extension Circle {
    // full circle style
    func circleBorderStyle(borderClr: String, borderWidth: CGFloat, circleWidth: CGFloat) -> some View {
        self
            .stroke(Color(borderClr), style: StrokeStyle(lineWidth: borderWidth, lineCap: .round))
            .frame(width: circleWidth, height: circleWidth, alignment: .center)
    }
    // trimmed circle style
    func trimCircleBorderStyle(checkConditionTrim: Bool, start: CGFloat, end: CGFloat, borderClr: String, borderWidth: CGFloat, circleWidth: CGFloat) -> some View {
        self
            .trim(from: checkConditionTrim ? 0.19 : 0, to: checkConditionTrim ? 0.89 : 1)
            .stroke(Color(borderClr), style: StrokeStyle(lineWidth: borderWidth, lineCap: .round))
            .frame(width: circleWidth, height: circleWidth, alignment: .center)
    }
}
