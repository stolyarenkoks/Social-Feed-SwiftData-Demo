//
//  FeedViewModel.swift
//  SocialFeedDemo
//
//  Created by Konstantin Stolyarenko on 25.01.2024.
//  Copyright © 2024 SKS. All rights reserved.
//

import SwiftData
import SwiftUI

// MARK: - FeedViewModel

extension FeedView {

    // MARK: - ViewModel

    @MainActor class ViewModel: ObservableObject {

        // MARK: - Internal Properties

        @Published var posts: [Post] = []
        @Published var selectedPost: Post?
        @Published var searchText = ""

        @Published var isPostDetailsPresented = false
        @Published var isActionSheetPresented = false

        var isCreatePostPresented: Binding<Bool>

        let currentUser: User = Application.currentUser

        var filteredPosts: [Post] {
            guard !searchText.isEmpty else { return posts }
            let filteredPosts = posts.compactMap { item in
                let titleContainsQuery = item.text.range(of: searchText, options: .caseInsensitive) != nil
                return titleContainsQuery ? item : nil
            }
            return filteredPosts
        }

        var modelContext: ModelContext

        // MARK: - Init

        init(modelContext: ModelContext, isCreatePostPresented: Binding<Bool>) {
            self.modelContext = modelContext
            self.isCreatePostPresented = isCreatePostPresented
            self.fetchPosts()
        }

        // MARK: - Internal Methods

        func fetchPosts() {
            do {
                let descriptor = FetchDescriptor<Post>(sortBy: [SortDescriptor(\.date, order: .reverse)])
                posts = try modelContext.fetch(descriptor)
            } catch {
                print("Fetch failed")
            }
        }

        func like(post: Post) {
            withAnimation {
                post.likesCount += 1
            }
        }

        func delete(post: Post) {
            withAnimation {
                modelContext.delete(post)
                fetchPosts()
            }
        }

        func presentCreatePost() {
            isCreatePostPresented.wrappedValue.toggle()
        }

        func presentActionSheet(post: Post) {
            selectedPost = post
            isActionSheetPresented.toggle()
        }

        func showDetails(post: Post) {
            selectedPost = post
            isPostDetailsPresented.toggle()
        }

        func showUserProfile() {
            print("Show User Profile")
        }
    }
}
