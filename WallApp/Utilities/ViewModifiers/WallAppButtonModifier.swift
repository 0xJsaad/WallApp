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


// Animation for stay Anonymously button


struct PulsatingQuestionmarkIcon: View {
    @State private var scaleEffect: CGFloat = 1.0

    var body: some View {
        Image(systemName: "person.fill.questionmark")
            .resizable()
            .scaledToFit()
            .frame(width: 24, height: 24)
            .scaleEffect(scaleEffect)
            .onAppear {
                startPulsating()
            }
    }
    
    func startPulsating() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                scaleEffect = 1.1
            }
        }
    }
}


// Anonymous button modifier
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
                    PulsatingQuestionmarkIcon()
                        .foregroundColor(.white)
                        .padding(.leading)
                    Spacer()
                }
            )
            .cornerRadius(8)
    }
}
#Preview {
    LoginView()
}
