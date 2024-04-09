//
//  Post.swift
//  SocialFeedDemo
//
//  Created by Konstantin Stolyarenko on 03.10.2023.
//  Copyright © 2024 SKS. All rights reserved.
//

import SwiftData
import UIKit

@Model
final class Post {
    let id: UUID = UUID()
    var userId: UUID = UUID()
    var text: String = ""
    var likesCount: Int = Int.zero
    let date: Date = Date.now

    @Attribute(.externalStorage)
    private var imageData: Data?

    /// Any computed properties are automatically transient.
    var image: UIImage? {
        if let imageData = imageData {
            return UIImage(data: imageData)
        }
        return nil
    }

    init(
        id: UUID = UUID(),
        userId: UUID,
        text: String,
        likesCount: Int = .zero,
        date: Date = .now,
        imageData: Data? = nil
    ) {
        self.id = id
        self.userId = userId
        self.text = text
        self.likesCount = likesCount
        self.date = date
        self.imageData = imageData
    }
}

extension Post {

    static func mock(
        id: UUID = UUID(),
        userId: UUID = User.mock().id,
        text: String = "Everything is proceeding very quickly and new frameworks will be released as well as existing ones will" +
        " be improved. Despite this, now, in 2023, there is a clear trend in the combination of Swift + SwiftUI + Combine, " +
        "each of which Apple continues to develop and improve, so for the next year, and most likely several, " +
        "this set will only replace the old one 🚀",
        likesCount: Int = 6,
        date: Date = .now,
        imageData: Data? = UIImage.userPost.jpegData(compressionQuality: 0.1)
    ) -> Self {
        .init(
            id: id,
            userId: userId,
            text: text,
            likesCount: likesCount,
            date: date,
            imageData: imageData
        )
    }
}
