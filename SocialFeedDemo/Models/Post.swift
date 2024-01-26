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
