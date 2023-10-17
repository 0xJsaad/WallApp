//
//  WallAppButtonModifier.swift
//  WallApp
//
//  Created by 0xJs on 10/16/23.
//

import SwiftUI

struct WallAppButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .frame(width: 352, height: 44)
            .background(.black)
            .cornerRadius(8)
    }
}
