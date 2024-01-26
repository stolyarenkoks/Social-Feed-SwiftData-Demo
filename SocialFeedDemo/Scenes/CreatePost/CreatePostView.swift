//
//  CreatePostView.swift
//  SocialFeedDemo
//
//  Created by Konstantin Stolyarenko on 03.10.2023.
//  Copyright © 2024 SKS. All rights reserved.
//

import PhotosUI
import SwiftUI

struct CreatePostView: View {

    // MARK: - Private Properties

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss

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
                    prompt: Text(Const.CreatePost.textFieldPlaceholder)
                        .foregroundColor(Color(uiColor: .darkGray)),
                    axis: .vertical
                )
                .padding()

                Spacer()

                if let image = viewModel.selectedImage {
                    imagePreview(uiImage: image)
                }

                HStack(spacing: 24.0) {
                    imagePicker()

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
                .padding(24.0)
            }
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

    private func imagePreview(uiImage: UIImage) -> some View {
        ZStack {
            Image(uiImage: uiImage)
                .resizable()

            Color.black.opacity(0.3)
        }
        .frame(height: 200)
        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
        .padding(.horizontal, 16.0)
        .overlay(alignment: .topTrailing) {
            removeImageButton()
        }
    }

    private func removeImageButton() -> some View {
        Button(action: {
            viewModel.removeImage()
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
                .foregroundColor(Color(uiColor: .white))
        })
        .padding(.vertical, 24.0)
        .padding(.horizontal, 32.0)
    }

    private func imagePicker() -> some View {
        PhotosPicker(selection: $viewModel.imagePickerItem, matching: .images) {
            Image(systemName: "photo")
        }
        .onChange(of: viewModel.imagePickerItem) {
            Task {
                await viewModel.prepareImage()
            }
        }
    }

    private func addPost() {
        let newPost = Post(text: viewModel.textFieldText, imageData: viewModel.selectedImageData)
        modelContext.insert(newPost)
        dismiss()
    }
}

// MARK: - Preview

#Preview {
    CreatePostView(viewModel: .init())
}
