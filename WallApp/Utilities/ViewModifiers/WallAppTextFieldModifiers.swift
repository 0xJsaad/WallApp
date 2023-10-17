//
//  WallAppTextFieldModifiers.swift
//  WallApp
//
//  Created by 0xJs on 10/16/23.
//

import SwiftUI

struct WallAppTextFieldModifiers: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .padding(12)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal, 24)
    }
}
