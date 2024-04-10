//
//  MainTabView.swift
//  SocialFeedDemo
//
//  Created by Konstantin Stolyarenko on 26.01.2024.
//  Copyright © 2024 SKS. All rights reserved.
//

import SwiftData
import SwiftUI

// MARK: - MainTabView

struct MainTabView: View {

    // MARK: - Private Properties

    @State private var isCreatePostPresented = false
    @State private var selectedTab = 1

    private var modelContext: ModelContext

    // MARK: - Init

    init(modelContext: ModelContext) {
        self.modelContext = modelContext

        let appeareance = UITabBarAppearance()
        appeareance.backgroundColor = .systemBackground

        UITabBar.appearance().standardAppearance = appeareance
        UITabBar.appearance().scrollEdgeAppearance = appeareance
    }

    // MARK: - Body

    var body: some View {
        TabView(selection: $selectedTab) {

            FeedView(viewModel: .init(modelContext: modelContext, isCreatePostPresented: $isCreatePostPresented))
                .tabItem({
                    Label(Const.MainTabView.homeTitle, systemImage: "house")
                })
                .tag(1)

            EmptyStateView(type: .notImplemented)
                .tabItem({
                    Label(Const.MainTabView.myNetworkTitle, systemImage: "person.2")
                })
                .tag(2)

            Color(uiColor: .systemBackground)
                .tabItem({
                    Label(Const.MainTabView.postTitle, systemImage: "plus.app")
                })
                .tag(3)

            EmptyStateView(type: .notImplemented)
                .tabItem({
                    Label(Const.MainTabView.notificationsTitle, systemImage: "bell")
                })
                .tag(4)

            EmptyStateView(type: .notImplemented)
                .tabItem({
                    Label(Const.MainTabView.jobsTitle, systemImage: "briefcase")
                })
                .tag(5)
        }
        .accentColor(.primary)
        .onChange(of: selectedTab) { _, _ in
            if selectedTab == 3 {
                isCreatePostPresented = true
                selectedTab = .zero
            }
        }
    }
}

// MARK: - Preview

#Preview("No Post") {
    do {
        let previewer = try PostsPreviewer()
        return MainTabView(modelContext: previewer.container.mainContext)
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}

#Preview("3 Posts") {
    do {
        let previewer = try PostsPreviewer(posts: [.mock(), .mock(), .mock()])
        return MainTabView(modelContext: previewer.container.mainContext)
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
