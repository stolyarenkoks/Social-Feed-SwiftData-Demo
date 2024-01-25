//
//  CreatePostViewModel.swift
//  SocialFeedDemo
//
//  Created by Konstantin Stolyarenko on 25.01.2024.
//  Copyright © 2024 SKS. All rights reserved.
//

import SwiftUI

// MARK: - CreatePostViewModel

extension CreatePostView {

    // MARK: - ViewModel

    @MainActor class ViewModel: ObservableObject {

        // MARK: - Internal Properties

        @Published var newPost: Item = Item(timestamp: .now)
        @Published var textFieldText: String = ""

        var isPostValid: Bool {
            textFieldText.count >= 3
        }
    }
}
