//
//  FeedViewModel.swift
//  SocialFeedDemo
//
//  Created by Konstantin Stolyarenko on 25.01.2024.
//  Copyright © 2024 SKS. All rights reserved.
//

import SwiftUI

// MARK: - FeedViewModel

extension FeedView {

    // MARK: - ViewModel

    @MainActor class ViewModel: ObservableObject {

        // MARK: - Internal Properties

        @Published var isCreatePostPresented = false
        @Published var isPostDetailsPresented = false
        @Published var isActionSheetPresented = false
        @Published var selectedPost: Post?
        @Published var searchText = ""

        let currentUser: User = Application.currentUser

        // MARK: - Internal Methods

        func like(post: Post) {
            withAnimation {
                post.likesCount += 1
            }
        }

        func presentCreatePost() {
            isCreatePostPresented.toggle()
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
