//
//  Item.swift
//  SocialFeedDemo
//
//  Created by Konstantin Stolyarenko on 03.10.2023.
//  Copyright © 2024 SKS. All rights reserved.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date

    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
