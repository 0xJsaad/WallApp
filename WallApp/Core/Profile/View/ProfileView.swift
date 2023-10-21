//
//  ProfileView.swift
//  WallApp
//
//  Created by 0xJs on 10/16/23.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    @State private var selectedFilter: ProfileWallFilter = .walls
    @Namespace var animation
    
    private var currentUser: User? {
        return viewModel.currentUser
    }
    
    // Check if the user is anonymous
    private var isUserAnonymous: Bool {
        AuthService.shared.isUserAnonymous
    }
    
    // State to activate NavigationLink
    @State private var redirectToSignUp: Bool = false
    
    var body: some View {
        NavigationView {
            NavigationStack {
                ScrollView(showsIndicators: false) {
                    // bio and stats
                    VStack(spacing: 20) {
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 12) {
                                // fullname and username
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(currentUser?.fullname ?? "")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                    
                                    Text(currentUser?.username ?? "")
                                        .font(.subheadline)
                                }
                                
                                if let bio = currentUser?.bio {
                                    Text(bio)
                                        .font(.footnote)
                                }
                                
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
                                            .fontWeight(selectedFilter == filter ? .semibold :
                                                    .regular)
                                        
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
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            AuthService.shared.signOut()
                        } label: {
                            Text("Log out")
                                .foregroundColor(.purple)
                        }
                        
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    ProfileView()
}
