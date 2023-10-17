//
//  CircularProfileImageView.swift
//  WallApp
//
//  Created by 0xJs on 10/17/23.
//

import SwiftUI

struct CircularProfileImageView: View {
    var body: some View {
        Image("Encara-messi")
            .resizable()
            .scaledToFill()
            .frame(width: 40, height: 40)
            .clipShape(Circle())
    }
}

#Preview {
    CircularProfileImageView()
}
