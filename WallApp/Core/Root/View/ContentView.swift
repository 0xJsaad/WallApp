//
//  ContentView.swift
//  WallApp
//
//  Created by 0xJs on 10/16/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                WallAppTabView()
            } else {
                LoginView()
            }
         }
    }
}

#Preview {
    ContentView()
}

