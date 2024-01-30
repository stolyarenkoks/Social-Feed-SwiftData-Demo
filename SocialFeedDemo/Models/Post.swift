//
//  Post.swift
//  SocialFeedDemo
//
//  Created by Konstantin Stolyarenko on 03.10.2023.
//  Copyright © 2024 SKS. All rights reserved.
//

import Foundation
import SwiftData

@Model
final class Post {
    var text: String

    @Attribute(.externalStorage)
    var imageData: Data?

    var date: Date

    init(text: String = "", imageData: Data? = nil, date: Date = .now) {
        self.text = text
        self.imageData = imageData
        self.date = date
    }
}

extension Post {

    static func mock(imageData: Data? = nil) -> Post {
        return Post(
            text: "Everything is proceeding very quickly and new frameworks will be released as well as existing ones will" +
            " be improved. Despite this, now, in 2023, there is a clear trend in the combination of Swift + SwiftUI + Combine, " +
            "each of which Apple continues to develop and improve, so for the next year, and most likely several, " +
            "this set will only replace the old one 🚀",
            imageData: imageData,
            date: .now
        )
    }
}
