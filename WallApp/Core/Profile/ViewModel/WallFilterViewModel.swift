//
//  WallFilterViewModel.swift
//  WallApp
//
//  Created by 0xJs on 10/23/23.
//
import Foundation

enum WallFilterViewModel: Int, CaseIterable {
    case walls
    case replies
    case likes
    
    var title: String {
        switch self {
            case .walls: return "Walls"
            case .replies: return "Replies"
            case .likes: return "Likes"
        }
    }
}
