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

    @State private var selectedTab = 1

    // MARK: - Body

    var body: some View {
        TabView(selection: $selectedTab) {
            FeedView(viewModel: .init())
                .tabItem({
                    Label("Home", systemImage: "house")
                })
                .tag(1)

            Color.white
                .tabItem({
                    Label("My Network", systemImage: "person.2")
                })
                .tag(2)

            Color.white
                .tabItem({
                    Label("Post", systemImage: "plus.app")
                })
                .tag(3)

            Color.white
                .tabItem({
                    Label("Notifications", systemImage: "bell")
                })
                .tag(4)

            Color.white
                .tabItem({
                    Label("Jobs", systemImage: "briefcase")
                })
                .tag(5)
        }
        .accentColor(.black)
    }
}

// MARK: - Preview

#Preview {
    MainTabView()
}
