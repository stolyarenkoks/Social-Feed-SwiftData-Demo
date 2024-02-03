//
//  TruncableTextView.swift
//  SocialFeedDemo
//
//  Created by Konstantin Stolyarenko on 02.02.2024.
//  Copyright © 2024 SKS. All rights reserved.
//

import SwiftUI

// MARK: - TruncableTextView

struct TruncableTextView: View {

    // MARK: - Internal Properties

    let text: Text
    let lineLimit: Int?
    let isTruncatedUpdate: (_ isTruncated: Bool) -> Void

    // MARK: - Private Properties

    @State private var intrinsicSize: CGSize = .zero
    @State private var truncatedSize: CGSize = .zero

    // MARK: - Body

    var body: some View {
        text
            .lineLimit(lineLimit)
            .readSize { size in
                truncatedSize = size
                isTruncatedUpdate(truncatedSize != intrinsicSize)
            }
            .background(
                text
                    .fixedSize(horizontal: false, vertical: true)
                    .hidden()
                    .readSize { size in
                        intrinsicSize = size
                        isTruncatedUpdate(truncatedSize != intrinsicSize)
                    }
            )
    }
}
