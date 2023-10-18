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
            .background(.purple)
            .cornerRadius(8)
    }
}
struct AnonymousLoginButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .frame(width: 352, height: 44)
            .background(Color.purple.opacity(0.7)) 
            .overlay(
                HStack {
                    Text("🎭") //
                        .font(.largeTitle)
                        .padding(.leading)
                    Spacer()
                }
            )
            .cornerRadius(8)
    }
}
