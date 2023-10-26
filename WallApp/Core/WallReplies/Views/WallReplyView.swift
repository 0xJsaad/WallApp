//
//  WallReplyView.swift
//  WallApp
//
//  Created by 0xJs on 10/25/23.
//

import SwiftUI

struct WallReplyView: View {
    let wall: Wall
    @State private var replyText = ""
    @State private var wallViewHeight: CGFloat = 24
    @Environment(\.dismiss) var dismiss

    private var currentUser: User? {
        return UserService.shared.currentUser
    }
    
    func setWallViewHeight() {
        let imageDimension: CGFloat = ProfileImageSize.small.dimension
        let padding: CGFloat = 16
        let width = UIScreen.main.bounds.width - imageDimension - padding
        let font = UIFont.systemFont(ofSize: 12)
        
        let captionSize = wall.caption.heightWidthConstraineWidth(width, font: font)
        
        print("DEBUG: caption size is \(captionSize)")
        
        wallViewHeight = captionSize + imageDimension - 16
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Divider()
                
                VStack(alignment: .leading, spacing: 12) {
                    HStack(alignment: .top) {
                        VStack {
                            CircularProfileImageView(user: wall.user, size: .small)
                            
                            Capsule()
                                .frame(width: 3, height: wallViewHeight)
                                .foregroundColor(.purple)
                        }
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(wall.user?.username ?? "")
                                .fontWeight(.semibold)
                            
                            Text(wall.caption)
                                .multilineTextAlignment(.leading)
                        }
                        .font(.footnote)
                        
                        Spacer()
                    }
                    
                    HStack(alignment: .top) {
                        CircularProfileImageView(user: currentUser, size: .small)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(currentUser?.username ?? "")
                            
                            TextField("Add your reply...", text: $replyText, axis: .vertical)
                                .multilineTextAlignment(.leading)
                        }
                        .font(.footnote)
                    }
                }
                .padding()
                
                Spacer()
            }
            .onAppear { setWallViewHeight() }
            .navigationTitle("Reply")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .font(.subheadline)
                    .foregroundColor(.purple)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Post") {
                        dismiss()
                    }
                    .opacity(replyText.isEmpty ? 0.5 : 1.0)
                    .disabled(replyText.isEmpty)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.purple)
                }
            }
        }
    }
}

#Preview {
    WallReplyView(wall: PreviewProvider.dev.wall)
}
