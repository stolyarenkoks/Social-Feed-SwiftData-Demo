//
//  Post.swift
//  SocialFeedDemo
//
//  Created by Konstantin Stolyarenko on 03.10.2023.
//  Copyright © 2024 SKS. All rights reserved.
//

import SwiftData
import SwiftUI

@Model
final class Post {
    var text: String
    var imageData: Data?
    var date: Date

    init(text: String = "", image: UIImage? = nil, date: Date = .now) {
        self.text = text
        self.imageData = image?.pngData()
        self.date = date
    }
}
