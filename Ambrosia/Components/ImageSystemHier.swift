//
//  ImageSystemHier.swift
//  Ambrosia
//
//  Created by Nhung Tran on 14/09/2022.
//

import SwiftUI

struct ImageSystemHier: View {
    let name: String
    let color: String
    let size: CGFloat
    
    var body: some View {
        Image(systemName: name)
            .resizable()
            .scaledToFit()
            .symbolRenderingMode(.hierarchical)
            .foregroundStyle(Color(color))
            .frame(width: size, height: size)
    }
}
