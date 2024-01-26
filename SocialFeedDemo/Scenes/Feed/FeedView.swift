//
//  FeedView.swift
//  SocialFeedDemo
//
//  Created by Konstantin Stolyarenko on 03.10.2023.
//  Copyright © 2024 SKS. All rights reserved.
//

import SwiftData
import SwiftUI

struct FeedView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var posts: [Post]

    @State private var isPresented = false

    // MARK: - Private Properties

    @ObservedObject private var viewModel: ViewModel

    // MARK: - Init

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Body

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(posts) { post in
                    ZStack {
                        FeedPostView(post: post, isDetailed: false)

                        NavigationLink {
                            ScrollView {
                                FeedPostView(post: post, isDetailed: true)
                            }
                        } label: {
                            EmptyView()
                        }
                    }
                    .listRowInsets(EdgeInsets())
                    .alignmentGuide(.listRowSeparatorLeading) { _ in
                            .zero
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: {
                        self.isPresented.toggle()
                    }, label: {
                        Label("Create Post", systemImage: "plus")
                    })
                }
            }
            .fullScreenCover(isPresented: $isPresented) {
                CreatePostView(viewModel: .init())
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Post()
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(posts[index])
            }
        }
    }
}

#Preview {
    FeedView(viewModel: .init())
        .modelContainer(for: Post.self, inMemory: true)
}
