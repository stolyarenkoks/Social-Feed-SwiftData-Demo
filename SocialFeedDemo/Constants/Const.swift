//
//  Const.swift
//  SocialFeedDemo
//
//  Created by Konstantin Stolyarenko on 25.01.2024.
//  Copyright © 2024 SKS. All rights reserved.
//

import Foundation

// MARK: - AnimationTime Enum

enum AnimationTime: TimeInterval {
    case slowest = 1.0
    case extremelySlow = 0.9
    case verySlow = 0.8
    case quiteSlow = 0.7
    case slow = 0.6
    case `default` = 0.5
    case fast = 0.4
    case quiteFast = 0.3
    case veryFast = 0.2
    case extremelyFast = 0.1
    case fastest = 0.0
}

// MARK: - AlphaState Enum

enum AlphaState: CGFloat {
    case visible = 1.0
    case translucent = 0.5
    case invisible = 0.0
}

// MARK: - Const

enum Const {

    // MARK: - General

    enum General {
        static let bulletPointSymbol = "•"
    }

    // MARK: - Enums

    enum EmptyStateType {
        static let noPostsTitle = "No posts available at the moment"
        static let notImplementedTitle = "Module is unavailable at the moment"
    }

    // MARK: - Navigation

    enum MainTabView {
        static let homeTitle = "Home"
        static let myNetworkTitle = "My Network"
        static let postTitle = "Post"
        static let notificationsTitle = "Notifications"
        static let jobsTitle = "Jobs"
    }

    // MARK: - Views

    enum FeedPostView {
        static let actionSheetTitle = "What do you want to do with the post?"
        static let actionSheetDeleteButtonTitle = "Delete Post"

        static let seeMoreButtonTitle = "See more"
        static let likeButtonTitle = "Like"
        static let commentButtonTitle = "Comment"
        static let repostButtonTitle = "Repost"
        static let sendButtonTitle = "Send"
    }

    // MARK: - Scenes

    enum FeedView {
        static let title = ""
    }

    enum CreatePost {
        static let title = ""

        static let textFieldPlaceholder = "What do you want to talk about?"
        static let anyoneTitle = "Anyone"
        static let postButtonTitle = "Post"
    }
}
