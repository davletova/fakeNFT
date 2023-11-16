//
//  StatisticViewModel.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 13.11.2023.
//

import Foundation
import Combine

enum ListUserError: Error {
    case unknownError
    case invalidAvatarURL
    case invalidWebsiteURL
}

enum UsersSortParameter: String {
    case byName = "name"
    case byRating = "rating"
}

enum UsersSortOrder: String {
    case asc = "asc"
    case desc = "desc"
}

struct UserViewModel: Equatable, Identifiable {
    var index: Int
    var user: User
    
    var id: String {
        user.id
    }
    
    func getAvatarURL() -> URL? {
        URL.fromRawString(user.avatar)
    }
    
    func getWebsiteURL() -> URL? {
        URL.fromRawString(user.website)
    }
}

class StatisticViewModel: ObservableObject {
    private var service: UserServiceProtocol
    private let usersPerPage = 20
    private var subscriptions = Set<AnyCancellable>()
  
    @Published var users: [UserViewModel] = []
    var page = 1
    var canLoadNextPage = true
    
    var sortParameter = UsersSortParameter.byName
    var sortOrder = UsersSortOrder.asc
        
    init(service: UserServiceProtocol) {
        self.service = service
    }
    
    func fetchNextPageIfPossible() {
        guard canLoadNextPage else { return }
        
        service.listUser(usersPerPage: usersPerPage, nextPage: page, sortParameter: sortParameter, sortOrder: sortOrder)
            .map { users in
                users.map { UserViewModel(index: 1, user: $0) }
            }
            .sink(receiveCompletion: onReceiveC,
                  receiveValue: onReceive)
            .store(in: &subscriptions)
    }
    
    private func onReceiveC(_ completion: Subscribers.Completion<Error>) {
        if case .failure(_) = completion {
            canLoadNextPage = false
        }
    }
    
    private func onReceive(_ batch: [UserViewModel]) {
        users += batch
        page += 1
        canLoadNextPage = batch.count == usersPerPage
    }
}
