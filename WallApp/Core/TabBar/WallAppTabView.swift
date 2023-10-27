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
    @State private var showAnonymousTab = false
    @EnvironmentObject var viewModel: ContentViewModel
    
    func getViewForTab(_ tab: Int) -> some View {
        if viewModel.isUserAnonymous && (tab == 1 || tab == 3 || tab == 4) {
            return AnyView(AnonymousView())
        }
        switch tab {
        case 1: return AnyView(ExploreView())
        case 3: return AnyView(NotificationRow())
        case 4: return AnyView(CurrentUserProfileView())
        default: return AnyView(EmptyView())
        }
    }
    
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                FeedView()
                    .tabItem {
                        Image(systemName: selectedTab == 0 ? "person.2.square.stack.fill" : "person.2.square.stack")
                            .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
                    }
                    .tag(0)
                
                
                getViewForTab(1)
                    .tabItem {
                        Image(systemName: "sparkle.magnifyingglass")
                    }
                    .tag(1)
                
                Text("")
                    .tabItem {
                        Image(systemName: "plus")
                    }
                    .tag(2)
                
                getViewForTab(3)
                    .tabItem {
                        Image(systemName: selectedTab == 3 ? "heart.fill" : "heart")
                            .environment(\.symbolVariants, selectedTab == 3 ? .fill : .none)
                    }
                    .tag(3)
                
                getViewForTab(4)
                    .tabItem {
                        Image(systemName: selectedTab == 4 ? "person.fill" : "person")
                            .environment(\.symbolVariants, selectedTab == 4 ? .fill : .none)
                    }
                    .tag(4)
            }
            .foregroundColor(.primary)
            
            .onChange(of: selectedTab, perform: { newValue in
                if newValue == 2 {
                    if viewModel.isUserAnonymous {
                        showAnonymousTab = false
                    } else {
                        showCreatedWallView = true
                    }
                }
            })
            .sheet(isPresented: $showAnonymousTab, onDismiss: {
                selectedTab = 0
            }, content: {
                AnonymousView()
            })
            .sheet(isPresented: $showCreatedWallView, onDismiss: {
                selectedTab = 0
            }, content: {
                CreateWallView()
            })
            .tint(.purple)
            
            // Third view for anonymous users who go to the "+" tab
            if selectedTab == 2 && !showAnonymousTab && viewModel.isUserAnonymous {
                VStack(spacing: 20) { // Add spacing between the text and the button
                    Spacer()
                    
                    Text("Guests can't post on the wall.")
                        .font(.headline)
                        .foregroundColor(.purple)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(.purple), lineWidth: 1)
                                .shadow(radius: 5)
                        )
                    
                    Button(action: {
                        withAnimation {
                            selectedTab = 4
                        }
                    }) {
                        Text("Go to Profile to Sign Up")
                            .font(.headline)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(.purple)
                                    .shadow(radius: 5)
                            )
                            .foregroundColor(.white) // Set text color to white for better contrast against the purple background
                    }
                    
                    Spacer()
                }
                .transition(.slide)
            }
        }
    }
}

#Preview {
    WallAppTabView().environmentObject(ContentViewModel())

}
