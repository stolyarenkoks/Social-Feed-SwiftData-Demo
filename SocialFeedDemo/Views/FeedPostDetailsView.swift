//
//  FeedPostDetailsView.swift
//  SocialFeedDemo
//
//  Created by Konstantin Stolyarenko on 26.01.2024.
//  Copyright © 2024 SKS. All rights reserved.
//

import SwiftUI

// MARK: - FeedPostDetailsView

struct FeedPostDetailsView: View {

    // MARK: - Internal Properties

    let post: Post
    let user: User
    let likePostAction: (() -> Void)?

    // MARK: - Body

    var body: some View {
        ScrollView {
            FeedPostView(post: post, user: user, isDetailed: true, likePostAction: likePostAction)
                .toolbar(.hidden, for: .tabBar)
        }
    }
}

// MARK: - Previews

#Preview("Not Detailed") {
    FeedPostDetailsView(
        post: .mock(),
        user: .mock(),
        likePostAction: {}
    )
}
