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
    let isDetailed: Bool
    let deletePostAction: ((UUID) -> Void)?

    // MARK: - Private Properties

    @State private var showingOptions = false

    // MARK: - Init

    init(post: Post, isDetailed: Bool = false, deletePostAction: ((UUID) -> Void)? = nil) {
        self.post = post
        self.isDetailed = isDetailed
        self.deletePostAction = deletePostAction
        self.showingOptions = showingOptions
    }

    // MARK: - Body

    var body: some View {
        VStack {
            if !isDetailed {
                Spacer()
            }

            VStack(spacing: 12.0) {
                userInfo()

                postText()

                if let image = post.image {
                    postImage(uiImage: image)
                }

                postReactions()

                postActions()
            }
            .background(.white)
        }
        .actionSheet(isPresented: $showingOptions) {
            ActionSheet(
                title: Text("What do you want to do with the post?"),
                buttons: [
                    .destructive(Text("Delete Post")) {
                        print("Delete Post with Id: \(post.id)")
                        deletePostAction?(post.id)
                    },
                    .cancel()
                ]
            )
        }
    }

    private func userInfo() -> some View {
        HStack {
            Image(uiImage: User.current.image ?? UIImage.user)
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(alignment: .bottomTrailing) {
                    Circle()
                        .frame(width: 11, height: 11)
                        .foregroundStyle(.green)
                }

            VStack(alignment: .leading, spacing: .zero) {
                HStack(spacing: 4) {
                    Text(User.current.fullName)
                        .font(.callout)
                        .bold()

                    if post.userId == User.current.id {
                        Text("• You")
                            .font(.footnote)
                            .foregroundStyle(Color(uiColor: UIColor.darkGray))
                    }
                }

                Text(User.current.jobTitle)
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

            if !isDetailed {
                Button(action: {
                    showingOptions = true
                }, label: {
                    Image(systemName: "ellipsis")
                        .font(.title3)
                })
                .foregroundStyle(Color(uiColor: UIColor.darkGray))
                .padding(.top, -16)
            }
        }
        .padding(.horizontal)
        .padding(.top, 12.0)
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
        post: .mock(),
        isDetailed: false
    )
}

#Preview("Not Detailed - w/o Image") {
    FeedPostView(
        post: .mock(imageData: nil),
        isDetailed: false
    )
}

#Preview("Detailed - Image") {
    FeedPostView(
        post: .mock(),
        isDetailed: true
    )
}

#Preview("Detailed - w/o Image") {
    FeedPostView(
        post: .mock(imageData: nil),
        isDetailed: true
    )
}
