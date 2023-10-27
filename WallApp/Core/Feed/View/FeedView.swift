//
//  FeedView.swift
//  WallApp
//
//  Created by 0xJs on 10/16/23.
//

import SwiftUI

struct FeedView: View {
    @StateObject var viewModel = FeedViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(viewModel.walls) { wall in
                        NavigationLink(value: wall) {
                            WallCell(wall: wall)
                            
                        }
                    }
                }
            }
            .refreshable {
                Task { try await viewModel.fetchWalls() }
            }
            .navigationDestination(for: Wall.self, destination: { wall in
                WallDetailsView(wall: wall)
            })
            .navigationTitle("Wall")
            .navigationBarTitleDisplayMode(.inline)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                        .foregroundColor(.purple)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        FeedView()
    }
}
