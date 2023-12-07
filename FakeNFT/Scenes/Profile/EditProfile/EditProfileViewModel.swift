//
//  EditProfileViewModel.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 23.11.2023.
//

import Foundation
import Combine

struct EditProfileDisplayModel {
    var profile: Profile
    
    func getAvatarURL() -> URL? {
        URL.fromRawString(profile.avatar)
    }
    
    func getWebsiteURL() -> URL? {
        URL.fromRawString(profile.website)
    }
}

class EditProfileViewModel: ObservableObject {
    @Published var editProfileDisplayModel: EditProfileDisplayModel
    @Published var name: String
    @Published var nameIsValid = true
    
    private var publishers = Set<AnyCancellable>()
    
    private var service: ProfileServiceProtocol
    
    init(profile: EditProfileDisplayModel, service: ProfileServiceProtocol) {
        self.editProfileDisplayModel = profile
        self.name = profile.profile.name
        self.service = service

        isUserNameValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.nameIsValid, on: self)
            .store(in: &publishers)
    }
}

extension EditProfileViewModel {
    var isUserNameValidPublisher: AnyPublisher<Bool, Never> {
        $name
            .map { name in
                return name.count > 0
            }
            .eraseToAnyPublisher()
    }
    
    func updateProfile() {
        let updateProfile = editProfileDisplayModel.profile
        
        service.updateProfile(updateProfile)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
//                    self.profile.profile = updateProfile
                    self.name = updateProfile.name
                    print("Request completed successfully.")
                case .failure(let error):
                    print("Request failed with error: \(error)")
                }
            }, receiveValue: {
                print("Request completed without returning a value.")
            })
            .store(in: &publishers)
    }
}
