//
//  Modifiers.swift
//  Ambrosia
//
//  Created by Khanh Tran Nguyen Ha on 10/09/2022.
//

import SwiftUI


struct TextFieldModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .frame(minWidth: Constants.FIELD_MIN_WIDTH, maxWidth: Constants.FIELD_MAX_WIDTH)
            .padding()
            .background(.thinMaterial)
            .cornerRadius(Constants.CONRNER_RADIUS)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
    }
}
