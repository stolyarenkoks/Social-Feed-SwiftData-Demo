//
//  FeedPostView.swift
//  SocialFeedDemo
//
//  Created by Konstantin Stolyarenko on 26.01.2024.
//  Copyright © 2024 SKS. All rights reserved.
//

import SwiftUI

struct FeedPostView: View {

    // MARK: - Internal Properties

    let post: Post
    var isDetailed: Bool = false

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            Text(post.text)
                .padding(.horizontal, 16.0)
                .lineLimit(isDetailed ? nil : 3)

            if let imageData = post.imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: isDetailed ? .fit : .fill)
                    .frame(maxHeight: isDetailed ? .infinity : 300)
                    .clipped()
            }

            Text(post.date, format: Date.FormatStyle(date: .numeric, time: .standard))
                .padding(.horizontal, 16.0)

            Spacer()
        }
    }
}

// MARK: - Previews

#Preview("Not Detailed") {
    FeedPostView(
        post: .init(
            text: "Post Text\nline2\nline3\nline4",
            imageData: UIImage(named: "userImage")?.pngData(),
            date: .now),
        isDetailed: false
    )
}

#Preview("Detailed") {
    FeedPostView(
        post: .init(
            text: "Post Text\nline2\nline3\nline4",
            imageData: UIImage(named: "userImage")?.pngData(),
            date: .now),
        isDetailed: true
    )
}
