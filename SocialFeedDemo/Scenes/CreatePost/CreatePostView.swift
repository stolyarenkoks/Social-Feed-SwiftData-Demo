//
//  CreatePostView.swift
//  SocialFeedDemo
//
//  Created by Konstantin Stolyarenko on 03.10.2023.
//  Copyright © 2024 SKS. All rights reserved.
//

import SwiftUI

struct CreatePostView: View {

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss

    @State var newPost: Item = Item(timestamp: .now)

    // MARK: - Private Properties

    @ObservedObject private var viewModel: ViewModel

    // MARK: - Init

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Body

    var body: some View {
        NavigationView {
            List {
                VStack {
                    Text("Post Date: \(newPost.timestamp)")
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: dismiss.callAsFunction) {
                        Text("Close")
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: addItem) {
                        Text("Post")
                    }
                }
            }
        }
    }

    private func addItem() {
        modelContext.insert(newPost)
        dismiss()
    }
}

#Preview {
    CreatePostView(viewModel: .init())
}
