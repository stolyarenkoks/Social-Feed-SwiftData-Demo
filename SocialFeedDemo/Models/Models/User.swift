//
//  User.swift
//  SocialFeedDemo
//
//  Created by Konstantin Stolyarenko on 30.01.2024.
//  Copyright © 2024 SKS. All rights reserved.
//

import UIKit

final class User: Codable {

    let id: UUID
    let fullName: String
    let jobTitle: String
    let imageName: String

    var image: UIImage? {
        .init(named: imageName)
    }

    init(
        id: UUID = UUID(),
        fullName: String,
        jobTitle: String,
        imageName: String
    ) {
        self.id = id
        self.fullName = fullName
        self.jobTitle = jobTitle
        self.imageName = imageName
    }
}

extension User {

    static func mock(
        id: UUID = UUID(),
        fullName: String = "👨🏻‍💻 Konstantin Stolyarenko",
        jobTitle: String = "iOS Technical Lead | Senior iOS Software Engineer",
        imageName: String = "userImage"
    ) -> Self {
        .init(
            id: id,
            fullName: fullName,
            jobTitle: jobTitle,
            imageName: imageName
        )
    }
}
