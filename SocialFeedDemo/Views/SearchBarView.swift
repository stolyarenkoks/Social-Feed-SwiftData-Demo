//
//  SearchBarView.swift
//  SocialFeedDemo
//
//  Created by Konstantin Stolyarenko on 07.02.2024.
//  Copyright © 2024 SKS. All rights reserved.
//

import SwiftUI

// MARK: - SearchBarView

struct SearchBarView: View {

    // MARK: - Internal Properties

    @Binding var searchText: String

    // MARK: - Body

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .font(.caption2)
                .foregroundStyle(Color(uiColor: .darkGray))

            TextField(
                "",
                text: $searchText,
                prompt: Text("Search")
                    .foregroundStyle(Color(uiColor: .darkGray))
            )
            .font(.caption)
        }
        .padding(.horizontal, 8.0)
        .padding(.vertical, 8.0)
        .background(Color(uiColor: .systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 4.0))
    }
}

// MARK: - Previews

#Preview("Not Detailed") {
    SearchBarView(searchText: .constant(""))
        .padding()
}
