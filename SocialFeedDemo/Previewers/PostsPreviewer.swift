//
//  PostsPreviewer.swift
//  SocialFeedDemo
//
//  Created by Konstantin Stolyarenko on 10.04.2024.
//  Copyright © 2024 SKS. All rights reserved.
//

import SwiftData

// MARK: - Posts Previewer

@MainActor
struct PostsPreviewer {

    // MARK: - Internal Properties

    let container: ModelContainer

    // MARK: - Init

    init(posts: [Post] = []) throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: Post.self, configurations: config)
        posts.forEach { container.mainContext.insert($0) }
    }
}
