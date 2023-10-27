//
//  UserContentListView.swift
//  WallApp
//
//  Created by 0xJs on 10/22/23.
//

import SwiftUI


struct UserContentListView: View {
    @StateObject var viewModel: UserContentListViewModel
    @State private var selectedFilter: ProfileWallFilter = .walls
    @Namespace var animation
    
    private var filterBarWidht: CGFloat {
        let count = CGFloat(ProfileWallFilter.allCases.count )
        return UIScreen.main.bounds.width / count - 16
    }
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: UserContentListViewModel(user: user))
    }
    
    // Check if the user is anonymous
    private var isUserAnonymous: Bool {
        AuthService.shared.isUserAnonymous
    }
    
    // State to activate NavigationLink
    @State private var redirectToSignUp: Bool = false
    
    var body: some View {
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
                switch selectedFilter {
                case .walls:
                    ForEach(viewModel.walls) { wall in
                        WallCell(wall: wall)
                            .transition(.move(edge: .leading))
                    }
                case .replies:
                    ForEach(viewModel.replies) { reply in
                        WallReplyProfileCell(reply: reply)
                            .transition(.move(edge: .trailing))
                    }
                }
            }
        }
        .padding(.vertical, 8)
        
    }
}


#Preview {
    UserContentListView(user: PreviewProvider.dev.user)
}
