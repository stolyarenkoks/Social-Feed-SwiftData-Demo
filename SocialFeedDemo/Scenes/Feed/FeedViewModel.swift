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

        @Published var carModelName: String = ""

        var isCarModelNameValid: Bool {
            carModelName.count >= 3
        }
    }
}
