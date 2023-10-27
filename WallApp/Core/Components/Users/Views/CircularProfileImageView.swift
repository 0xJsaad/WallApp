//
//  CircularProfileImageView.swift
//  WallApp
//
//  Created by 0xJs on 10/17/23.
//
import Kingfisher
import SwiftUI

enum ProfileImageSize {
    case xxSmall
    case xSmall
    case small
    case medium
    case large
    case xLarge

    var dimension: CGFloat {
        switch self {
        case .xxSmall: return 28
        case .xSmall: return 32
        case .small: return 40
        case .medium: return 48
        case .large: return 64
        case .xLarge: return 80
        }
    }
}


struct CircularProfileImageView: View {
    var user: User?
    let size: ProfileImageSize
    
    var body: some View {
        if let imageUrl = user?.profileImageUrl {
            KFImage(URL(string: imageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
                .foregroundColor(Color(.systemGray4))
        }
    }
}

#Preview {
    CircularProfileImageView(user: PreviewProvider.dev.user, size: .medium)
}
