//
//  EmptyStateType.swift
//  SocialFeedDemo
//
//  Created by Konstantin Stolyarenko on 02.02.2024.
//

import Foundation

enum EmptyStateType {
    case noPosts
    case notImplemented

    var title: String {
        switch self {
        case .noPosts:
            "No posts available at the moment"
        case .notImplemented:
            "Module is unavailable at the moment"
        }
    }

    var animationName: String {
        switch self {
        case .noPosts:
            "no-posts-animation"
        case .notImplemented:
            "not-implemented-animation"
        }
    }
}
