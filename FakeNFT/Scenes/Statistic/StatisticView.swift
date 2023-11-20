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
    @State private var isConfirming = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.users) { (userVM: UserDisplayModel) in
                        //TODO: обработать кейс когда url == nil
                        UserItemView(number: userVM.index, name: userVM.user.name, avatarURL: userVM.getAvatarURL()!, position: userVM.user.rating)
                            .onAppear {
                                if viewModel.users.last == userVM {
                                    viewModel.fetchNextPageIfPossible()
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
                viewModel.sortParameter = .byName
                viewModel.sortOrder = .asc
                viewModel.users = []
                viewModel.page = 1
                viewModel.canLoadNextPage = true
                
                viewModel.fetchNextPageIfPossible()
            }

            Button("По рейтингу") {
                viewModel.sortParameter = .byRating
                viewModel.sortOrder = .asc
                viewModel.users = []
                viewModel.page = 1
                viewModel.canLoadNextPage = true
                
                viewModel.fetchNextPageIfPossible()
            }

            Button("Закрыть", role: .cancel) { }
        }
        .onAppear(perform: viewModel.fetchNextPageIfPossible)
    }
}
