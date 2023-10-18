//
//  UserCell.swift
//  WallApp
//
//  Created by 0xJs on 10/17/23.
//

import SwiftUI

struct UserCell: View {
    var body: some View {
        HStack {
            CircularProfileImageView()
            
            VStack(alignment: .leading) {
                Text("leomessi_10")
                    .fontWeight(.semibold)
                
                Text("Leo Messi")

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
        .padding(.vertical)
    }
}

#Preview {
    UserCell()
}
