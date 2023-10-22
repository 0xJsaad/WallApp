//
//  UserCOntentListView.swift
//  WallApp
//
//  Created by 0xJs on 10/22/23.
//

import SwiftUI


struct UserCOntentListView: View {
    @State private var selectedFilter: ProfileWallFilter = .walls
    @Namespace var animation
    
    private var filterBarWidht: CGFloat {
        let count = CGFloat(ProfileWallFilter.allCases.count )
        return UIScreen.main.bounds.width / count - 16
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
                ForEach(0 ... 10, id: \.self) { wall in
                    WallCell()
                }
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    UserCOntentListView()
}
