//
//  ProfileWallFilter.swift
//  WallApp
//
//  Created by 0xJs on 10/17/23.
//

import Foundation

enum ProfileWallFilter: Int, CaseIterable, Identifiable {
    case walls
    case wallReplies
    
    var title: String {
        switch self {
        case .walls: return "Wall"
        case .wallReplies: return "Wall Replies"
        }
    }
    
    var id: Int { return self.rawValue }
}
