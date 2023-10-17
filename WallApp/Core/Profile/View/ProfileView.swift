//
//  ProfileView.swift
//  WallApp
//
//  Created by 0xJs on 10/16/23.
//

import SwiftUI

struct ProfileView: View {
    @State private var selectedFilter: ProfileWallFilter = .walls
    @Namespace var animation
    var body: some View {
        ScrollView(showsIndicators: false) {
            // bio and stats
            VStack(spacing: 20) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 12) {
                        // fullname and username
                        VStack(alignment: .leading, spacing: 4) {
                         Text("Leo Messi")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            Text("leomessi_10")
                                .font(.subheadline)
                        }
                        
                        Text("Campeones del mundo!!")
                            .font(.footnote)
                        
                        Text("2 followers")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    CircularProfileImageView()
                }
                
                Button {
                    
                } label: {
                    Text("Follow")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                        .frame(width: 352, height: 32)
                        .background(.purple)
                        .cornerRadius(8)
                }
                
                // user content list view
                VStack {
                    HStack {
                        ForEach(ProfileWallFilter.allCases) { filter in
                            VStack {
                                Text(filter.title)
                                    .font(.subheadline)
                                    .fontWeight(selectedFilter == filter ? .semibold : .regular)
                                
                                if selectedFilter == filter {
                                    Rectangle()
                                        .foregroundColor(.purple)
                                        .frame(width: 180, height: 1)
                                        .matchedGeometryEffect(id: "item", in: animation)
                                    
                                    
                                } else {
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .frame(width: 180, height: 1)
                                }
                                
                            }
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    selectedFilter = filter
                                }
                            }
                        }
                    }
                    
                    
                    LazyVStack {
                        ForEach(0 ... 10, id: \.self) { wall in
                            WallCell()
                        }
                    }
                }
                .padding(.vertical, 8)
                
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    ProfileView()
}
