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
    
    @State private var isConfirming = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(Array(users.enumerated()), id: \.offset) { index, user in
                        UserItemView(number: index + 1, name: user.name, avatarURL: user.avatar, position: user.rating)
                            .onAppear {
                                if users.last == user {
                                    onScrolledAtBottom()
                                }
                            }
                    }
                }
            }
            .toolbar {
                Button {
                    self.isConfirming = true
                } label: {
                    Image("sort")
                }
            }
        }
        .confirmationDialog("Сортировка", isPresented: $isConfirming, titleVisibility: .visible) {
            Button("По имени") {
//                selection = "Red"
            }

            Button("По рейтингу") {
//                selection = "Green"
            }

            Button("Закрыть", role: .cancel) {
//                selection = "Blue"
            }
        }
    }
}
