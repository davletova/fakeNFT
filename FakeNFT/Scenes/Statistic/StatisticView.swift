//
//  StatisticView.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 13.11.2023.
//

import Foundation
import SwiftUI

struct ListUsersContainer: View {
    @ObservedObject var viewModel: StatisticViewModel
    
    var body: some View {
        ListUsers(
            users: viewModel.state.users,
            isLoading: viewModel.state.canLoadNextPage,
            onScrolledAtBottom: viewModel.fetchNextPageIfPossible
        )
        .onAppear(perform: viewModel.fetchNextPageIfPossible)
    }
}

struct ListUsers: View {
    let users: [UserVM]
    let isLoading: Bool
    let onScrolledAtBottom: () -> Void
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(Array(users.enumerated()), id: \.offset) { index, user in
                    UserItemView(number: index + 1, name: user.name, avatarURL: user.avatar, position: user.rating)
//                        .frame(maxWidth: UIScreen.main.bounds.width - 32)
//                        .frame(height: 80)
//                        .listRowSeparator(.hidden)
                        .onAppear {
                            if users.last == user {
                                onScrolledAtBottom()
                            }
                        }
                }
            }
            .padding(.horizontal, 16)
//            .scrollContentBackground(.hidden)
        }
    }
}
