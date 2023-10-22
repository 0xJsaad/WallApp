//
//  CreateThreadView.swift
//  WallApp
//
//  Created by 0xJs on 10/16/23.
//

import SwiftUI

struct CreateWallView: View {
    @State private var caption = ""
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(alignment: .top) {
                    CircularProfileImageView(user: nil, size: .small)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("leomessi_10")
                            .fontWeight(.semibold)
                        
                        TextField("Start a wall post...", text: $caption, axis: .vertical)
                    }
                    .font(.footnote)
                    
                    Spacer()
                    
                    if !caption.isEmpty {
                        Button{
                            caption = ""
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 12, height: 12)
                                .foregroundColor(.gray)
                        }
                    }
                    
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("New Wall post")
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
                        
                    }
                    .opacity(caption.isEmpty ? 0.5 : 1.0)
                    .disabled(caption.isEmpty)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.purple)
                }
                
            }
        }
    }
}
    

#Preview {
    CreateWallView()
}
