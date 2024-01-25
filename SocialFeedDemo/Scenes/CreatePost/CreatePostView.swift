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

    // MARK: - Private Properties

    @ObservedObject private var viewModel: ViewModel

    // MARK: - Init

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Body

    var body: some View {
        NavigationView {
            VStack {
                TextField(
                    "",
                    text: $viewModel.textFieldText,
                    prompt: Text("What do you want to talk about?")
                        .foregroundColor(Color(uiColor: .darkGray)),
                    axis: .vertical
                )
                .padding(.vertical, 8.0)

                Spacer()

                HStack(spacing: 24.0) {

                    Button(action: dismiss.callAsFunction) {
                        Image(systemName: "photo")
                    }

                    Button(action: dismiss.callAsFunction) {
                        Image(systemName: "square.grid.3x3.square")
                    }

                    Button(action: dismiss.callAsFunction) {
                        Image(systemName: "calendar")
                    }

                    Button(action: dismiss.callAsFunction) {
                        Image(systemName: "ellipsis")
                    }

                    Spacer()
                }
                .foregroundColor(Color(uiColor: .darkGray))
                .font(.title3)
                .padding(.horizontal, 16.0)
                .padding(.vertical, 8.0)
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Button(action: dismiss.callAsFunction) {
                            Image(systemName: "xmark")
                                .font(.headline)
                                .foregroundColor(Color(uiColor: .darkGray))
                        }

                        Button(action: dismiss.callAsFunction) {
                            HStack(spacing: 16.0) {
                                Image("userImage")
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                    .clipShape(.capsule)

                                Text("Anyone")
                                    .font(.headline)
                                    .foregroundColor(Color(uiColor: .darkGray))
                            }
                        }
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Button(action: dismiss.callAsFunction) {
                            Image(systemName: "clock")
                                .font(.headline)
                                .foregroundColor(Color(uiColor: .darkGray))
                        }

                        postButton()
                    }
                }
            }
        }
    }

    private func postButton() -> some View {
        Button(action: addPost) {
            Text("Post")
                .font(.callout)
                .bold()
                .foregroundStyle(viewModel.isPostValid ? .white : Color(uiColor: .systemGray))
                .padding(8)
                .background(viewModel.isPostValid ? .blue : Color(uiColor: .systemGray5))
                .clipShape(.capsule)
        }
        .disabled(!viewModel.isPostValid)
    }

    private func addPost() {
        viewModel.newPost.text = viewModel.textFieldText
        modelContext.insert(viewModel.newPost)
        dismiss()
    }
}

#Preview {
    CreatePostView(viewModel: .init())
}
