//
//  FeedView.swift
//  SocialFeedDemo
//
//  Created by Konstantin Stolyarenko on 03.10.2023.
//  Copyright © 2024 SKS. All rights reserved.
//

import SwiftUI

struct FeedView: View {

    // MARK: - Private Properties

    @ObservedObject private var viewModel: ViewModel

    // MARK: - Init

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Body

    var body: some View {
        NavigationStack {
            Group {
                if !viewModel.posts.isEmpty {
                    ScrollView {
                        LazyVStack {
                            ForEach(viewModel.filteredPosts) { post in
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
                    .overlay {
                        if viewModel.filteredPosts.isEmpty { ContentUnavailableView.search }
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
            .fullScreenCover(isPresented: viewModel.isCreatePostPresented, onDismiss: {
                viewModel.fetchPosts()
            }, content: {
                CreatePostView(viewModel: .init(modelContext: viewModel.modelContext))
            })
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color(uiColor: .systemBackground), for: .navigationBar)
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
                    guard let post = $viewModel.selectedPost.wrappedValue else { return }
                    viewModel.delete(post: post)
                },
                .cancel()
            ]
        )
    }
}

// MARK: - Preview

#Preview("No Post") {
    do {
        let previewer = try PostsPreviewer()
        return FeedView(viewModel: .init(modelContext: previewer.container.mainContext, isCreatePostPresented: .constant(false)))
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}

#Preview("1 Post") {
    do {
        let previewer = try PostsPreviewer(posts: [.mock()])
        return FeedView(viewModel: .init(modelContext: previewer.container.mainContext, isCreatePostPresented: .constant(false)))
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}

#Preview("3 Posts") {
    do {
        let previewer = try PostsPreviewer(posts: [.mock(), .mock(), .mock()])
        return FeedView(viewModel: .init(modelContext: previewer.container.mainContext, isCreatePostPresented: .constant(false)))
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
