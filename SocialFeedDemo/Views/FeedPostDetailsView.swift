//
//  FeedPostDetailsView.swift
//  SocialFeedDemo
//
//  Created by Konstantin Stolyarenko on 26.01.2024.
//

import SwiftUI

struct FeedPostDetailsView: View {

    // MARK: - Internal Properties

    let post: Post

    // MARK: - Body

    var body: some View {
        ScrollView {
            FeedPostView(post: post, isDetailed: true)
                .toolbar(.hidden, for: .tabBar)
        }
    }
}

// MARK: - Previews

#Preview("Not Detailed") {
    FeedPostDetailsView(
        post: .init(
            text: "Post Text\nline2\nline3\nline4",
            imageData: UIImage(named: "userImage")?.pngData(),
            date: .now)
    )
}
