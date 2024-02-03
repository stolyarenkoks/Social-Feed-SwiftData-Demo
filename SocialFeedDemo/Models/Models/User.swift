//
//  User.swift
//  SocialFeedDemo
//
//  Created by Konstantin Stolyarenko on 30.01.2024.
//  Copyright © 2024 SKS. All rights reserved.
//

import UIKit

final class User {
    let id: UUID
    var fullName: String
    var jobTitle: String
    var image: UIImage?

    init(
        id: UUID = UUID(),
        fullName: String,
        jobTitle: String,
        image: UIImage?
    ) {
        self.id = id
        self.fullName = fullName
        self.jobTitle = jobTitle
        self.image = image
    }
}

extension User {

    static func mock(
        id: UUID = UUID(),
        fullName: String = "👨🏻‍💻 Konstantin Stolyarenko",
        jobTitle: String = "iOS Technical Lead | Senior iOS Software Engineer",
        image: UIImage? = .user
    ) -> Self {
        .init(
            id: id,
            fullName: fullName,
            jobTitle: jobTitle,
            image: image
        )
    }

    static let current: User = .mock()
}
