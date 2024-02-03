//
//  EmptyStateType.swift
//  SocialFeedDemo
//
//  Created by Konstantin Stolyarenko on 02.02.2024.
//  Copyright © 2024 SKS. All rights reserved.
//

import Foundation

enum EmptyStateType {
    case noPosts
    case notImplemented

    var title: String {
        switch self {
        case .noPosts:
            Const.EmptyStateType.noPostsTitle
        case .notImplemented:
            Const.EmptyStateType.notImplementedTitle
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
