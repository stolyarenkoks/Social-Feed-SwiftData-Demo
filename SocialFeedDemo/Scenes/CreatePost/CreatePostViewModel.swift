//
//  CreatePostViewModel.swift
//  SocialFeedDemo
//
//  Created by Konstantin Stolyarenko on 25.01.2024.
//  Copyright © 2024 SKS. All rights reserved.
//

import PhotosUI
import SwiftUI

// MARK: - CreatePostViewModel

extension CreatePostView {

    // MARK: - ViewModel

    @MainActor class ViewModel: ObservableObject {

        // MARK: - Internal Properties

        @Published var textFieldText: String = ""
        @Published var imagePickerItem: PhotosPickerItem?
        @Published var selectedImageData: Data?
        @Published var shouldDismiss: Bool = false

        var selectedImage: UIImage? {
            if let imageData = selectedImageData {
                return UIImage(data: imageData)
            }
            return nil
        }

        var isPostValid: Bool {
            textFieldText.count >= 3
        }

        let currentUser: User = Application.currentUser

        // MARK: - Internal Methods

        func prepareImage() async {
            if let imageData = try? await imagePickerItem?.loadTransferable(type: Data.self) {
                selectedImageData = imageData
            } else {
                print("CreatePostView: Failed to load image!")
            }
        }

        func removeImage() {
            imagePickerItem = nil
            selectedImageData = nil
        }

        func dismiss() {
            shouldDismiss = true
        }
    }
}
