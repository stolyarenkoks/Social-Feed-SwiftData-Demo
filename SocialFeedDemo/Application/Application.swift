//
//  Application.swift
//  SocialFeedDemo
//
//  Created by Konstantin Stolyarenko on 03.10.2023.
//  Copyright © 2024 SKS. All rights reserved.
//

import SwiftData
import SwiftUI

@main
struct Application: App {

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Post.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    static var currentUser: User {
        guard let data = UserDefaults.standard.object(forKey: Const.UserDefaults.currentUserKey) as? Data,
              let user = try? JSONDecoder().decode(User.self, from: data) else {
            let newUser = User.mock()
            if let newUserData = try? JSONEncoder().encode(newUser) {
                UserDefaults.standard.set(newUserData, forKey: Const.UserDefaults.currentUserKey)
            }
            return newUser
        }
        return user
    }

    var body: some Scene {
        WindowGroup {
            MainTabView(modelContext: sharedModelContainer.mainContext)
        }
        .modelContainer(sharedModelContainer)
    }
}
