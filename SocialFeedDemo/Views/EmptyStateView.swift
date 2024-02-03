//
//  EmptyStateView.swift
//  SocialFeedDemo
//
//  Created by Konstantin Stolyarenko on 02.02.2024.
//  Copyright © 2024 SKS. All rights reserved.
//

import Lottie
import SwiftUI

// MARK: - EmptyStateView

struct EmptyStateView: View {

    // MARK: - Internal Properties

    let type: EmptyStateType

    // MARK: - Body

    var body: some View {
        ZStack {
            Color(uiColor: .systemGray6)

            LottieView(animation: .named(type.animationName))
                .playing(loopMode: .loop)

            Text(type.title)
                .multilineTextAlignment(.center)
                .padding(.top, type == .noPosts ? 350 : 400)
                .foregroundStyle(Color(uiColor: .systemGray))
        }
        .padding(.top, -50)
        .padding(.horizontal, type == .noPosts ? .zero : 40)
        .background(Color(uiColor: .systemGray6), ignoresSafeAreaEdges: .all)
    }
}

// MARK: - Previews

#Preview("EmptyStateView - noPosts") {
    EmptyStateView(type: .noPosts)
}

#Preview("EmptyStateView - notImplemented") {
    EmptyStateView(type: .notImplemented)
}
