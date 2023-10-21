//
//  UserCell.swift
//  WallApp
//
//  Created by 0xJs on 10/17/23.
//

import SwiftUI

struct UserCell: View {
    let user: User
    
    var body: some View {
        HStack {
            CircularProfileImageView()
            
            VStack(alignment: .leading, spacing: 4) {
                Text(user.username)
                    .fontWeight(.semibold)
                
                Text(user.fullname)

            }
            .font(.footnote)
            
            Spacer()
            
            Text("Follow")
                .font(.subheadline)
                .fontWeight(.semibold)
                .frame(width: 100, height: 32)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.purple), lineWidth: 1)
                }
        }
        .padding(.horizontal)
    }
}

#Preview {
    UserCell(user: PreviewProvider.dev.user)
}
