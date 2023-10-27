//
//  ProfileWallFilter.swift
//  WallApp
//
//  Created by 0xJs on 10/17/23.
//

import Foundation

enum ProfileWallFilter: Int, CaseIterable, Identifiable {
    case walls
    case replies
    
    var title: String {
        switch self {
        case .walls: return "walls"
        case .replies: return "replies"
        }
    }
    
    var id: Int { return self.rawValue }
}
