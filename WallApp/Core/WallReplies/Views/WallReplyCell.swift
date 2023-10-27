//
//  WallReplyCell.swift
//  WallApp
//
//  Created by 0xJs on 10/26/23.
//

import SwiftUI

struct WallReplyCell: View {
    let reply: WallReply
    
    private var user: User? {
        return reply.replyUser
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                CircularProfileImageView(user: user, size: .small)
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(user?.username ?? "")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Text(reply.timestamp.timestampString())
                            .font(.caption)
                            .foregroundColor(Color(.systemGray3))
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "poweron")
                                .foregroundColor(Color(.purple))
                        }
                    }
                    
                    Text(reply.replyText)
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                }
            }
            Divider()
        }
        .padding()
    }
}

#Preview {
    WallReplyCell(reply: PreviewProvider.dev.reply )
}
