//
//  ProfileViewModel.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 21.11.2023.
//

import Foundation
import Combine

struct ProfileDisplayModel {
    var profile: Profile
    
    func getAvatarURL() -> URL? {
        URL.fromRawString(profile.avatar)
    }
    
    func getWebsiteURL() -> URL? {
        URL.fromRawString(profile.website)
    }
}

class ProfileViewModel: ObservableObject {
    private var service: ProfileServiceProtocol
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var profile: ProfileDisplayModel?
    @Published var state: StateFoo
    
    init(service: ProfileServiceProtocol) {
        self.service = service
        self.state = .loading
        self.loadData()
    }
    
    func loadData() {
        //TODO: надо подставить id текущего пользователя
        service.getProfile(id: "1")
            .print("------", to:  nil)
            .map { profile in
                ProfileDisplayModel(profile: profile)
            }
            .mapError { [weak self] err in
                    self?.state = .failed(err)
                    return err
            }
            .sink(receiveCompletion: onReceiveC) { [weak self] (profileDisplayModel: ProfileDisplayModel) in
                self?.profile = profileDisplayModel
                self?.state = .loaded
            }
            .store(in: &subscriptions)
    }

    private func onReceiveC(_ completion: Subscribers.Completion<Error>) {}
}
