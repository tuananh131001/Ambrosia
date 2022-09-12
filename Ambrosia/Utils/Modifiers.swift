//
//  Modifiers.swift
//  Ambrosia
//
//  Created by Khanh Tran Nguyen Ha on 10/09/2022.
//

import SwiftUI


struct TextFieldModifier: ViewModifier{
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
