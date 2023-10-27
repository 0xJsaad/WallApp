//
//  WallReplyProfileCell.swift
//  WallApp
//
//  Created by 0xJs on 10/26/23.
//

import SwiftUI

struct WallReplyProfileCell: View {
    let reply: WallReply
    
    var body: some View {
        VStack(alignment: .leading) {
            if let wall = reply.wall {
                
                
                HStack(alignment: .top) {
                    VStack {
                        CircularProfileImageView(user: wall.user, size: .small)
                        
                        Capsule()
                            .frame(width: 4, height: 64)
                            .foregroundColor(Color(.purple))
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(wall.user?.username ?? "")
                                .fontWeight(.semibold)
                            
                            Text(wall.caption)
                        }
                        .font(.footnote)
                        
                        ContentActionButtonsView(wall: wall)

                    }
                    
                    Spacer()
                    
                }
            }
            
            HStack(alignment: .top) {
                CircularProfileImageView(user: reply.replyUser, size: .small)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(reply.replyUser?.username ?? "")
                        .fontWeight(.semibold)
                    
                    Text(reply.replyText)
                }
                .font(.footnote)
            }
            
            Divider()
                .padding(.bottom, 8)
        }
        .padding(.horizontal)
    }
}

#Preview {
    WallReplyProfileCell(reply: DeveloperPreview.shared.reply)
}
