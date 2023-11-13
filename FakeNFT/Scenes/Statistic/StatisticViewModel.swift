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

class StatisticViewModel: ObservableObject {
    struct State {
        var users: [UserVM] = []
        var page: Int = 1
        var canLoadNextPage = true
    }
    
    private var service: UserServiceProtocol
    private let usersPerPage = 20
    private var subscriptions = Set<AnyCancellable>()
    
    private var sortParameter = UsersSortParameter.byName
    private var sortOrder = UsersSortOrder.asc
    
    @Published var state = State()
    
    init(service: UserServiceProtocol) {
        self.service = service
    }
    
    func fetchNextPageIfPossible() {
        guard state.canLoadNextPage else { return }
        
        service.listUser(usersPerPage: usersPerPage, nextPage: state.page, sortParameter: sortParameter, sortOrder: sortOrder)
            .print("-------", to: nil)
            .tryMap { users in
                var userVMs: [UserVM] = []
                for user in users {
                    let userVM = try self.convertUserToUserVM(from: user)
                    userVMs.append(userVM)
                }
                return userVMs
            }
            .sink(receiveCompletion: onReceiveC,
                  receiveValue: onReceive)
            .store(in: &subscriptions)
    }
    
    private func onReceiveC(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure:
            state.canLoadNextPage = false
        }
    }
    
    private func onReceive(_ batch: [UserVM]) {
        state.users += batch
        state.page += 1
        state.canLoadNextPage = batch.count == usersPerPage
    }
    
    private func convertUserToUserVM(from user: User) throws -> UserVM {
        guard let str = user.avatar.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
              let avatarURL = URL(string: str)
        else {
            print("failed to create url from \(user.avatar)")
            throw ListUserError.invalidAvatarURL
        }
        
        guard let str = user.website.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
              let websietURL = URL(string: str)
        else {
            print("failed to create url from \(user.website)")
            throw ListUserError.invalidWebsiteURL
        }
        
        return UserVM(
            name: user.name,
            avatar: avatarURL,
            description: user.description,
            website: websietURL,
            nfts: user.nfts,
            rating: user.rating,
            id: user.id
        )
    }
}
