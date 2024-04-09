//
//  FeedPostView.swift
//  SocialFeedDemo
//
//  Created by Konstantin Stolyarenko on 26.01.2024.
//  Copyright © 2024 SKS. All rights reserved.
//

import Lottie
import SwiftUI

// MARK: - FeedPostView

struct FeedPostView: View {

    // MARK: - Private Properties

    @State private var isTruncated: Bool = false
    @State private var playbackMode: LottiePlaybackMode = .paused

    private let post: Post
    private let user: User
    private let isDetailed: Bool
    private let likePostAction: (() -> Void)?
    private let showMoreAction: (() -> Void)?
    private let showDetailsAction: (() -> Void)?

    // MARK: - Init

    init(
        post: Post,
        user: User,
        isDetailed: Bool = false,
        likePostAction: (() -> Void)? = nil,
        showMoreAction: (() -> Void)? = nil,
        showDetailsAction: (() -> Void)? = nil
    ) {
        self.post = post
        self.user = user
        self.isDetailed = isDetailed
        self.likePostAction = likePostAction
        self.showMoreAction = showMoreAction
        self.showDetailsAction = showDetailsAction
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
                        .overlay(alignment: .bottomLeading) {
                            animationView()
                        }
                }

                postReactions()
                postActions()
            }
            .background(.white)
        }
    }

    // MARK: - Private UI Elements

    private func userInfo() -> some View {
        HStack {
            Image(uiImage: user.image ?? UIImage.user)
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(alignment: .bottomTrailing) {
                    Circle()
                        .frame(width: 11, height: 11)
                        .foregroundStyle(.linkedInGreen)
                }

            VStack(alignment: .leading, spacing: .zero) {
                HStack(spacing: 4) {
                    Text(user.fullName)
                        .font(.callout)
                        .bold()

                    if post.userId == user.id {
                        Text("\(Const.General.bulletPointSymbol) You")
                            .font(.footnote)
                            .foregroundStyle(Color(uiColor: UIColor.darkGray))
                    }
                }

                Text(user.jobTitle)
                    .font(.caption)

                HStack(spacing: 4) {
                    Text(post.date, format: Date.FormatStyle(date: .complete, time: .standard))

                    Text(Const.General.bulletPointSymbol)

                    Image(systemName: "globe.americas.fill")
                }
                .font(.caption2)
                .foregroundStyle(Color(uiColor: UIColor.darkGray))
            }

            Spacer()

            if !isDetailed {
                Button {
                    showMoreAction?()
                } label: {
                    Image(systemName: "ellipsis")
                        .frame(width: 32, height: 32)
                        .font(.title3)
                        .foregroundStyle(Color(uiColor: UIColor.darkGray))
                        .padding(.top, -16)
                }
            }
        }
        .padding(.horizontal)
        .padding(.top, 12.0)
    }

    private func postText() -> some View {
        VStack {
            HStack {
                TruncableTextView(text: Text(post.text),
                                  lineLimit: isDetailed ? nil : 3) {
                    isTruncated = $0
                }
                .font(.footnote)
                .padding(.horizontal, 16.0)

                Spacer()
            }
        }
    }

    private func postImage(uiImage: UIImage) -> some View {
        Image(uiImage: uiImage)
            .resizable()
            .aspectRatio(contentMode: isDetailed ? .fit : .fill)
            .frame(maxHeight: isDetailed ? .infinity : 400)
            .contentShape(Rectangle())
            .clipped()
    }

    private func animationView() -> some View {
        LottieView(animation: .named("like-animation"))
            .animationSpeed(2.0)
            .playbackMode(playbackMode)
            .animationDidFinish { _ in
                playbackMode = LottiePlaybackMode.paused
            }
            .opacity(playbackMode != .paused ? 1 : .zero)
            .padding(.bottom, -8.0)
            .padding(.leading, -12.0)
    }

    private func postReactions() -> some View {
        HStack(spacing: -2) {
            reactionImage(imageName: "hand.thumbsup.fill", backgroundColor: .blue)
            reactionImage(imageName: "hands.clap.fill", backgroundColor: .purple)
            reactionImage(imageName: "heart.fill", backgroundColor: .red)

            Text("\(post.likesCount)")
                .contentTransition(.numericText())
                .padding(.horizontal, 8.0)
                .foregroundStyle(Color(uiColor: UIColor.darkGray))
                .font(.footnote)

            Spacer()

            if !isDetailed && isTruncated {
                Button {
                    showDetailsAction?()
                } label: {
                    HStack(spacing: 4) {
                        Text(Const.FeedPostView.seeMoreButtonTitle)
                            .font(.footnote)

                        Image(systemName: "chevron.right")
                            .font(.caption2)
                    }
                    .foregroundStyle(Color(uiColor: UIColor.darkGray))
                    .bold()
                }
            }
        }
        .padding(.horizontal)
    }

    private func postActions() -> some View {
        VStack(spacing: 8.0) {
            Color(uiColor: .systemGray3)
                .frame(maxHeight: 0.5)

            HStack(spacing: 65.0) {
                actionButton(imageName: "hand.thumbsup", title: Const.FeedPostView.likeButtonTitle, action: likeAction)
                .contextMenu(menuItems: {
                    ControlGroup {
                        actionButton(imageName: "hand.thumbsup.fill", action: likeAction)
                        actionButton(imageName: "hands.clap.fill", action: likeAction)
                        actionButton(imageName: "heart.fill", action: likeAction)
                    }
                    .controlGroupStyle(.compactMenu)
                })

                actionButton(imageName: "text.bubble", title: Const.FeedPostView.commentButtonTitle, action: {})
                actionButton(imageName: "arrow.2.squarepath", title: Const.FeedPostView.repostButtonTitle, action: {})
                actionButton(imageName: "paperplane.fill", title: Const.FeedPostView.sendButtonTitle, action: {})
            }
        }
        .padding(.bottom, 8.0)
    }

    private func actionButton(imageName: String, title: String? = nil, action: @escaping () -> Void) -> some View {
        Button(action: action, label: {
            VStack(spacing: 2) {
                Image(systemName: imageName)
                    .font(.footnote)

                if let title = title {
                    Text(title)
                        .font(.caption)
                }
            }
        })
        .foregroundStyle(Color(uiColor: UIColor.darkGray))
        .bold()
    }

    private func reactionImage(imageName: String, backgroundColor: Color) -> some View {
        Image(systemName: imageName)
            .frame(width: 16, height: 16)
            .foregroundStyle(.white)
            .background(backgroundColor)
            .clipShape(Circle())
            .font(.system(size: 9))
    }

    // MARK: - Actions

    private func likeAction() {
        playbackMode = .playing(.fromProgress(0, toProgress: 0.8, loopMode: .playOnce))
        likePostAction?()
    }
}

// MARK: - Previews

#Preview("Not Detailed - Image") {
    FeedPostView(
        post: .mock(),
        user: .mock(),
        isDetailed: false
    )
}

#Preview("Not Detailed - w/o Image") {
    FeedPostView(
        post: .mock(imageData: nil),
        user: .mock(),
        isDetailed: false
    )
}

#Preview("Detailed - Image") {
    FeedPostView(
        post: .mock(),
        user: .mock(),
        isDetailed: true
    )
}

#Preview("Detailed - w/o Image") {
    FeedPostView(
        post: .mock(imageData: nil),
        user: .mock(),
        isDetailed: true
    )
}
