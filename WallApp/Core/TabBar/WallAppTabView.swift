//
//  WallAppTabView.swift
//  WallApp
//
//  Created by 0xJs on 10/16/23.
//

import SwiftUI

struct WallAppTabView: View {
    @State private var selectedTab = 0
    @State private var showCreatedWallView = false
    
    var body: some View {
        TabView(selection: $selectedTab) {
            FeedView()
                .tabItem {
                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                        .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
                }
                .onAppear() { selectedTab = 0}
                .tag(0)
            
            ExploreView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
                .onAppear() { selectedTab = 1}
                .tag(1)
            
            Text("")
                .tabItem {
                    Image(systemName: "plus")
                }
                .onAppear() { selectedTab = 2}
                .tag(2)
            
            ActivityView()
                .tabItem {
                    Image(systemName: selectedTab == 3 ? "heart.fill" : "heart")
                        .environment(\.symbolVariants, selectedTab == 3 ? .fill : .none)
                }
                .onAppear() { selectedTab = 3}
                .tag(3)
            
            ProfileView()
                .tabItem {
                    Image(systemName: selectedTab == 4 ? "person.fill" : "person")
                        .environment(\.symbolVariants, selectedTab == 4 ? .fill : .none)
                }
                .onAppear() { selectedTab = 4}
                .tag(4)
        }
        .onChange(of: selectedTab) {
            showCreatedWallView = $0 == 2
        }
        .sheet(isPresented: $showCreatedWallView, onDismiss: {
            selectedTab = 0
        }, content: {
            CreateWallView()
        })
        .tint(.purple)
    }
}
#Preview {
    WallAppTabView()
}
