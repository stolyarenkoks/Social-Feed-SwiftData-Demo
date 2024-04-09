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
                                    likePostAction: { viewModel.like(post: post) },
                                    showMoreAction: { viewModel.presentActionSheet(post: post) },
                                    showDetailsAction: { viewModel.showDetails(post: post) }
                                )
                            }
                        }
                    }
                    .navigationDestination(isPresented: $viewModel.isPostDetailsPresented) {
                        postDetailsView()
                    }
                    .actionSheet(isPresented: $viewModel.isActionSheetPresented) {
                        actionSheet()
                    }
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

    // MARK: - Private UI Elements

    private func postDetailsView() -> some View {
        let post = $viewModel.selectedPost.wrappedValue ?? .mock(text: "Unselected Post")
        return FeedPostDetailsView(post: post,
                                   user: viewModel.currentUser,
                                   likePostAction: { viewModel.like(post: post) })
    }

    private func actionSheet() -> ActionSheet {
        ActionSheet(
            title: Text(Const.FeedPostView.actionSheetTitle),
            buttons: [
                .destructive(Text(Const.FeedPostView.actionSheetDeleteButtonTitle)) {
                    if let post = $viewModel.selectedPost.wrappedValue {
                        delete(post: post)
                    }
                },
                .cancel()
            ]
        )
    }

    // MARK: - Private Methods

    private func delete(post: Post) {
        withAnimation {
            modelContext.delete(post)
        }
    }
}

// MARK: - Preview

#Preview {
    FeedView(viewModel: .init())
        .modelContainer(for: [Post.self], inMemory: true)
}
