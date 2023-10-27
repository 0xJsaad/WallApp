//
//  WallDetailsView.swift
//  WallApp
//
//  Created by 0xJs on 10/26/23.
//

import SwiftUI

struct WallDetailsView: View {
    let wall: Wall
    @StateObject var viewModel: WallDetailsViewModel

    init(wall: Wall) {
        self.wall = wall
        self._viewModel = StateObject(wrappedValue: WallDetailsViewModel(wall: wall))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    CircularProfileImageView(user: wall.user, size: .small)
                    
                    Text(wall.user?.username ?? "")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Text(wall.timestamp.timestampString())
                        .font(.caption)
                        .foregroundColor(Color(.systemGray))
                    
                    Button {
                        
                    } label: {
                        Image(systemName:  "poweron")
                            .foregroundColor(Color(.purple))
                    }
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    Text(wall.caption)
                        .font(.subheadline)
                    
                    ContentActionButtonsView(wall: wall)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Divider()
                    .padding(.vertical)
                
                LazyVStack {
                    ForEach(viewModel.replies) { reply in
                        WallReplyCell(reply: reply)
                    }
                }
            }
        }
        .padding()
        .navigationTitle("Wall")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    WallDetailsView(wall: PreviewProvider.dev.wall)
}
