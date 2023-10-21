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
        case 3: return AnyView(ActivityView())
        case 4: return AnyView(ProfileView())
        default: return AnyView(EmptyView())
        }
    }

    
    var body: some View {
        TabView(selection: $selectedTab) {
            FeedView()
                .tabItem {
                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                        .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
                }
                .tag(0)
            
            
            getViewForTab(1)
                .tabItem {
                    Image(systemName: "magnifyingglass")
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
        .onChange(of: selectedTab, perform: { newValue in
                    if newValue == 2 {
                        if viewModel.isUserAnonymous {
                            showAnonymousTab = true
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
            }
        }

#Preview {
    WallAppTabView().environmentObject(ContentViewModel())

}
