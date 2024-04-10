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

    @Environment(\.dismiss) private var dismiss
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

                    Button("", systemImage: "square.grid.3x3.square") {}
                    Button("", systemImage: "calendar") {}
                    Button("", systemImage: "ellipsis") {}

                    Spacer()
                }
                .foregroundColor(Color(uiColor: .darkGray))
                .font(.title3)
                .padding(24.0)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Button("", systemImage: "xmark") {
                            viewModel.dismiss()
                        }
                        .font(.headline)
                        .foregroundColor(Color(uiColor: .darkGray))

                        Button {} label: {
                            HStack(spacing: 16.0) {
                                Image(uiImage: viewModel.currentUser.image ?? .user)
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                    .clipShape(.capsule)

                                Text(Const.CreatePost.anyoneTitle)
                                    .font(.headline)
                                    .foregroundColor(Color(uiColor: .darkGray))
                            }
                        }
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Button("", systemImage: "clock") {}
                            .font(.headline)
                            .foregroundColor(Color(uiColor: .darkGray))

                        postButton()
                    }
                }
            }
        }
        .onChange(of: viewModel.shouldDismiss) {
            dismiss()
        }
    }

    // MARK: - Private Methods

    private func postButton() -> some View {
        Button(action: viewModel.addPost) {
            Text(Const.CreatePost.postButtonTitle)
                .font(.callout)
                .bold()
                .foregroundStyle(viewModel.isPostValid ? .white : Color(uiColor: .systemGray))
                .padding(8)
                .background(viewModel.isPostValid ? .linkedInBlue : Color(uiColor: .systemGray5))
                .clipShape(.capsule)
        }
        .disabled(!viewModel.isPostValid)
    }

    private func imagePreview(uiImage: UIImage) -> some View {
        ZStack {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fill)

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
        Button("", systemImage: "xmark") {
            viewModel.removeImage()
        }
        .font(.headline)
        .foregroundColor(Color(uiColor: .white))
        .padding(.vertical, 16.0)
        .padding(.horizontal, 24.0)
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
}

// MARK: - Preview

#Preview {
    do {
        let previewer = try PostsPreviewer()
        return CreatePostView(viewModel: .init(modelContext: previewer.container.mainContext))
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
