//
//  ContentActionButtonsView.swift
//  WallApp
//
//  Created by 0xJs on 10/25/23.
//

import SwiftUI

struct ContentActionButtonsView: View {
    @ObservedObject var viewModel: ContentActionsButtonsViewModel
    @State private var showReplySheet = false
    
    init(wall: Wall) {
        self.viewModel =  ContentActionsButtonsViewModel(wall: wall)
    }
    
    private var didLike: Bool {
        return viewModel.wall.didLike ?? false
    }
    
    private var wall: Wall {
        return viewModel.wall
    }
    
    func handleLikeTapped() {
        Task {
            if didLike {
                try await viewModel.unlikeWall()
            } else {
                try await viewModel.likeWall()
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .center) {
            HStack(spacing: 35) {
                Button {
                    handleLikeTapped()
                } label: {
                    Image(systemName: viewModel.wall.didLike ?? false ? "heart.fill" : "heart")
                        .font(.headline)
                        .foregroundColor(viewModel.wall.didLike ?? false ? .red : .gray)
                }
                
                Button {
                    showReplySheet.toggle()
                } label: {
                    Image(systemName: "bubble.right")
                        .font(.headline)
                }
                
            }
            
            HStack(spacing: 4) {
                if wall.likes > 0 {
                    Text("\(wall.likes) likes")
                    
                } else {
                    Text("like ")
                    
                }
                if wall.replyCount >= 0 && wall.likes >= 0 {
                    Text("-")
                }
                if wall.replyCount > 0 {
                    Text("\(wall.replyCount) replies")

                } else {
                    Text(" reply")
                }
            }
            .font(.caption)
            .foregroundColor(.gray)
            .padding(.vertical, 4)
        }
        .sheet(isPresented: $showReplySheet) {
            WallReplyView(wall: wall)
        }
    }
}

#Preview {
    ContentActionButtonsView(wall: PreviewProvider.dev.wall)
}
