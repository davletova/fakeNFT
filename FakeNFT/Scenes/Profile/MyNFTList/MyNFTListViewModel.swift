//
//  MyNFTListViewModel.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 22.11.2023.
//

import Foundation
import SwiftUI
import Combine

struct MyNFTDisplayModel: Identifiable {
    var nft: NFT
    var isLike: Bool
    var author: String
    
    var id: Int { nft.id }
    
    func getImageURLs() -> [URL] {
        nft.images.compactMap { URL.fromRawString($0) }
    }
}

class MyNFTListViewModel: ObservableObject {
    private var nftService: NFTServiceProtocol
    private var profileService: ProfileServiceProtocol
    private var userService: UserServiceProtocol
    
    private var likes = Set<String>()
    private var onOrder = Set<String>()
    
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var nftDisplayModels: [MyNFTDisplayModel] = []
    @Published var state: StateFoo
    
    init(nftService: NFTServiceProtocol, profileService: ProfileServiceProtocol, userService: UserServiceProtocol) {
        self.nftService = nftService
        self.profileService = profileService
        self.userService = userService
        
        self.state = .loading
        self.loadData()
    }
    
    func loadData() {
        let likes$ = profileService.getProfileLikeNFTs()
        let nfts$ = profileService.getProfileNFTs()
        
        Publishers.CombineLatest(nfts$, likes$)
            .flatMap { (nfts, likeNFTs) in
                Publishers.MergeMany(nfts.map { nft in
                    self.userService.getUser(id: nft.author).map { (user: User) in
                        let isLike = likeNFTs.contains(where: { $0.id == nft.id })
                        return MyNFTDisplayModel(nft: nft, isLike: isLike, author: user.id.description)
                    }
                })
            }
            .collect()
            .eraseToAnyPublisher()
        
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            }, receiveValue: {[weak self] nfts in
                self?.state = .loaded
                self?.nftDisplayModels = nfts
            })
            .store(in: &subscriptions)
    }
}

