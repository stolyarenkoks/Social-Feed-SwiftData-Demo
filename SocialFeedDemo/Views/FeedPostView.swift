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
        VStack(alignment: .center, spacing: 12.0) {

            if !isDetailed {
                Color(uiColor: .systemGray6)
                    .frame(height: 10)
            }

            userInfo()

            postText()

            if let imageData = post.imageData, let uiImage = UIImage(data: imageData) {
                postImage(uiImage: uiImage)
            }

            postReactions()

            postActions()
        }
    }

    private func userInfo() -> some View {
        HStack {
            Image("userImage")
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(alignment: .bottomTrailing) {
                    Circle()
                        .frame(width: 11, height: 11)
                        .foregroundStyle(.green)
                }

            VStack(alignment: .leading, spacing: .zero) {
                Text("👨🏻‍💻 Konstantin Stolyarenko")
                    .font(.callout)
                    .bold()

                Text("iOS Technical Lead | Senior iOS Software Engineer")
                    .font(.caption)

                HStack(spacing: 4) {
                    Text(post.date, format: Date.FormatStyle(date: .complete, time: .standard))

                    Text("•")

                    Image(systemName: "globe.americas.fill")
                }
                .font(.caption2)
                .foregroundStyle(Color(uiColor: UIColor.darkGray))
            }

            Spacer()
        }
        .padding(.horizontal)
    }

    private func postText() -> some View {
        HStack {
            Text(post.text)
                .font(.footnote)
                .padding(.horizontal, 16.0)
                .lineLimit(isDetailed ? nil : 3)

            Spacer()
        }
    }

    private func postImage(uiImage: UIImage) -> some View {
        Image(uiImage: uiImage)
            .resizable()
            .aspectRatio(contentMode: isDetailed ? .fit : .fill)
            .frame(maxHeight: isDetailed ? .infinity : 400)
            .clipped()
    }

    private func postReactions() -> some View {
        HStack(spacing: -2) {
            Image(systemName: "hand.thumbsup.fill")
                .frame(width: 16, height: 16)
                .foregroundStyle(.white)
                .background(.blue)
                .clipShape(Circle())
                .font(.system(size: 9))

            Image(systemName: "hands.clap.fill")
                .frame(width: 16, height: 16)
                .foregroundStyle(.white)
                .background(.purple)
                .clipShape(Circle())
                .font(.system(size: 9))

            Image(systemName: "heart.fill")
                .frame(width: 16, height: 16)
                .foregroundStyle(.white)
                .background(.red)
                .clipShape(Circle())
                .font(.system(size: 9))

            Text("6")
                .padding(.horizontal, 8.0)
                .foregroundStyle(Color(uiColor: UIColor.darkGray))
                .font(.footnote)

            Spacer()
        }
        .padding(.horizontal)
    }

    private func postActions() -> some View {
        VStack(spacing: 8.0) {
            Color(uiColor: .systemGray3)
                .frame(maxHeight: 0.5)

            HStack(spacing: 65.0) {
                actionButton(imageName: "hand.thumbsup", title: "Like")
                actionButton(imageName: "text.bubble", title: "Comment")
                actionButton(imageName: "arrow.2.squarepath", title: "Repost")
                actionButton(imageName: "paperplane.fill", title: "Send")
            }
        }
        .padding(.bottom, 8.0)
    }

    private func actionButton(imageName: String, title: String) -> some View {
        Button(action: {}, label: {
            VStack(spacing: 2) {
                Image(systemName: imageName)
                    .font(.footnote)

                Text(title)
                    .font(.caption)
            }
        })
        .foregroundStyle(Color(uiColor: UIColor.darkGray))
        .bold()
    }
}

// MARK: - Previews

#Preview("Not Detailed - Image") {
    FeedPostView(
        post: .mock(imageData: UIImage(named: "userPost")?.pngData()),
        isDetailed: false
    )
}

#Preview("Not Detailed - w/o Image") {
    FeedPostView(
        post: .mock(),
        isDetailed: false
    )
}

#Preview("Detailed - Image") {
    FeedPostView(
        post: .mock(imageData: UIImage(named: "userPost")?.pngData()),
        isDetailed: true
    )
}

#Preview("Detailed - w/o Image") {
    FeedPostView(
        post: .mock(),
        isDetailed: true
    )
}
