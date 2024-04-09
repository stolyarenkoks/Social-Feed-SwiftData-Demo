//
//  FeedView.swift
//  SocialFeedDemo
//
//  Created by Konstantin Stolyarenko on 03.10.2023.
//  Copyright © 2024 SKS. All rights reserved.
//

import SwiftData
import SwiftUI

struct FeedView: View {

    // MARK: - Private Properties

    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Post.date, order: .reverse) private var posts: [Post]

    @ObservedObject private var viewModel: ViewModel

    // MARK: - Init

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Body

    var body: some View {
        NavigationStack {
            Group {
                if !posts.isEmpty {
                    ScrollView {
                        LazyVStack {
                            ForEach(posts) { post in
                                FeedPostView(
                                    post: post,
                                    user: viewModel.currentUser,
                                    likePostAction: { like(post: post) },
                                    deletePostAction: { delete(post: post) },
                                    showMoreAction: { viewModel.showDetails(post: post) }
                                )
                            }
                        }
                    }
                    .navigationDestination(isPresented: $viewModel.isPostDetailsPresented, destination: {
                        if let post = $viewModel.selectedPost.wrappedValue {
                            FeedPostDetailsView(post: post, user: viewModel.currentUser, likePostAction: { like(post: post) })
                        }
                    })
                } else {
                    EmptyStateView(type: .noPosts)
                }
            }
            .background(Color(uiColor: .systemGray6))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("", systemImage: "plus") {
                        viewModel.presentCreatePost()
                    }
                }

                ToolbarItem(placement: .principal) {
                    SearchBarView(searchText: $viewModel.searchText)
                }

                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        viewModel.showUserProfile()
                    } label: {
                        Image(uiImage: viewModel.currentUser.image ?? .user)
                            .resizable()
                            .frame(width: 35, height: 35)
                            .clipShape(.capsule)
                    }
                }
            }
            .fullScreenCover(isPresented: $viewModel.isCreatePostPresented) {
                CreatePostView(viewModel: .init())
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.white, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    // MARK: - Private Methods

    private func delete(post: Post) {
        withAnimation {
            modelContext.delete(post)
        }
    }

    private func like(post: Post) {
        withAnimation {
            post.likesCount += 1
        }
    }
}

// MARK: - Preview

#Preview {
    FeedView(viewModel: .init())
        .modelContainer(for: [Post.self], inMemory: true)
}
