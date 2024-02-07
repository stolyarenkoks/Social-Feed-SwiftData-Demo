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
        @Published var selectedPost: Post?
        @Published var searchText = ""

        let currentUser: User = Application.currentUser

        // MARK: - Internal Methods

        func presentCreatePost() {
            isCreatePostPresented.toggle()
        }

        func showDetails(post: Post) {
            selectedPost = post
            isPostDetailsPresented = true
        }

        func showUserProfile() {
            print("Show User Profile")
        }
    }
}
