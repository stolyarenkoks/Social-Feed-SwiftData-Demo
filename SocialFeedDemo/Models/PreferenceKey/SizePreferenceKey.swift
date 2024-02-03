//
//  SizePreferenceKey.swift
//  SocialFeedDemo
//
//  Created by Konstantin Stolyarenko on 02.02.2024.
//  Copyright © 2024 SKS. All rights reserved.
//

import SwiftUI

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}
