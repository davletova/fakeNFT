//
//  EditProfileViewModel.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 23.11.2023.
//

import Foundation
import Combine

class EditProfileViewModel: ObservableObject {
    @Published var profile: ProfileDisplayModel
    @Published var name: String
    @Published var description: String
    @Published var website: String
    
    init(profile: Profile) {
        //TODO: nfts и likes здесь не нужны
        self.profile = ProfileDisplayModel(profile: profile, nfts: [], likes: [])
        self.name = profile.name
        self.description = profile.description
        self.website = profile.website
    }
}
