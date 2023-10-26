//
//  ProfileViewModel.swift
//  WallApp
//
//  Created by 0xJs on 10/23/23.
//


import Foundation

class ProfileViewModel: ObservableObject {
    @Published var walls = [Wall]()
    @Published var likedWalls = [Wall]()
    private let userService = UserService()  // Removed service since we're using static methods
    
    let user: User
    
    init(user: User) {
        self.user = user
        Task {
            await self.fetchUserWalls()
        }
    }
    
    func walls(forFilter filter: WallFilterViewModel) -> [Wall] {
        switch filter {
        case .walls:
            return walls
        case .replies:
            return walls
        case .likes:
            return likedWalls
        }
    }
    
    func fetchUserWalls() async {
        do {
            let fetchedWalls = try await WallService.fetchUserWalls(uid: user.id)  // Using static call
            self.walls = fetchedWalls
            
            for index in 0 ..< fetchedWalls.count {
                self.walls[index].user = self.user
            }
        } catch {
            // Handle error appropriately
            print("Failed to fetch user walls:", error)
        }
    }
}
