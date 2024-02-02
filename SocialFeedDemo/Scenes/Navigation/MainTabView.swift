//
//  MainTabView.swift
//  SocialFeedDemo
//
//  Created by Konstantin Stolyarenko on 26.01.2024.
//

import SwiftUI

// MARK: - MainTabView

struct MainTabView: View {

    // MARK: - Private Properties

    @State private var isPresented = false
    @State private var selectedTab = 1

    // MARK: - Init

    init() {
        let appeareance = UITabBarAppearance()
        appeareance.backgroundColor = .systemBackground

        UITabBar.appearance().standardAppearance = appeareance
        UITabBar.appearance().scrollEdgeAppearance = appeareance
    }

    // MARK: - Body

    var body: some View {
        TabView(selection: $selectedTab) {

            FeedView(viewModel: .init())
                .tabItem({
                    Label("Home", systemImage: "house")
                })
                .tag(1)

            EmptyStateView(type: .notImplemented)
                .tabItem({
                    Label("My Network", systemImage: "person.2")
                })
                .tag(2)

            Color(uiColor: .systemBackground)
                .tabItem({
                    Label("Post", systemImage: "plus.app")
                })
                .tag(3)

            EmptyStateView(type: .notImplemented)
                .tabItem({
                    Label("Notifications", systemImage: "bell")
                })
                .tag(4)

            EmptyStateView(type: .notImplemented)
                .tabItem({
                    Label("Jobs", systemImage: "briefcase")
                })
                .tag(5)
        }
        .accentColor(.primary)
        .onChange(of: selectedTab) { _, _ in
            if selectedTab == 3 {
                isPresented = true
                selectedTab = .zero
            }
        }
        .fullScreenCover(isPresented: $isPresented) {
            CreatePostView(viewModel: .init())
        }
    }
}

// MARK: - Preview

#Preview {
    MainTabView()
        .modelContainer(for: [Post.self], inMemory: true)
}
