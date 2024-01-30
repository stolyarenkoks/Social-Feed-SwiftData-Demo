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
    @Attribute(.unique)
    let id: UUID

    let userId: UUID
    var text: String
    let date: Date

    @Attribute(.externalStorage)
    private var imageData: Data?

    var image: UIImage? {
        get {
            if let imageData = imageData {
                return UIImage(data: imageData)
            }
            return nil
        }
        set {
            imageData = newValue?.pngData()
        }
    }

    init(
        id: UUID = UUID(),
        userId: UUID,
        text: String,
        date: Date = .now,
        imageData: Data? = nil
    ) {
        self.id = id
        self.userId = userId
        self.text = text
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
        date: Date = .now,
        imageData: Data? = UIImage.userPost.pngData()
    ) -> Self {
        .init(
            id: id,
            userId: userId,
            text: text,
            date: date,
            imageData: imageData
        )
    }
}
