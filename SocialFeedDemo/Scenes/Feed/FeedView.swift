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
                        VStack {
                            ForEach(posts) { post in
                                FeedPostView(
                                    post: post,
                                    likePostAction: { likePost(id: post.id) },
                                    deletePostAction: { deletePost(id: post.id) },
                                    showMoreAction: { viewModel.showPostDetails(post: post) }
                                )
                            }
                        }
                    }
                } else {
                    EmptyStateView(type: .noPosts)
                }
            }
            .background(Color(uiColor: .systemGray6))
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        viewModel.presentCreatePost()
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
            }
            .fullScreenCover(isPresented: $viewModel.isCreatePostPresented) {
                CreatePostView(viewModel: .init())
            }
            .navigationDestination(isPresented: $viewModel.isPostDetailsPresented, destination: {
                if let post = $viewModel.selectedPost.wrappedValue {
                    FeedPostDetailsView(post: post)
                }
            })
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.white, for: .navigationBar)
        }
    }

    private func deletePost(id: UUID) {
        withAnimation {
            guard let postToDelete = posts.first(where: { $0.id == id }) else { return }
            modelContext.delete(postToDelete)
        }
    }

    private func likePost(id: UUID) {
        withAnimation {
            posts.first(where: { $0.id == id })?.likesCount += 1
        }
    }
}

// MARK: - Preview

#Preview {
    FeedView(viewModel: .init())
        .modelContainer(for: [Post.self], inMemory: true)
}
