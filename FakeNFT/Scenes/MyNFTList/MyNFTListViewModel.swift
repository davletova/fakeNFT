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
    
    var id: String { nft.id }
    
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
    
    init(nftIDs: [String], nftService: NFTServiceProtocol, profileService: ProfileServiceProtocol, userService: UserServiceProtocol) {
        self.nftService = nftService
        self.profileService = profileService
        self.userService = userService
        
        self.state = .loading
        self.loadData(nftIDs)
    }
    
    let emptyUser = User(name: "", avatar: "", description: "", website: "", nfts: [], rating: "", id: "")
    
    func loadData(_ nftIds: [String]) {
        let nftsUsers$ = nftIds.map({ nftId in
            self.nftService
                .getNFT(nftId)
                .flatMap { nft in
                    self.userService
                        .getUser(id: nft.author)
                        .map{ user in
                            (nft, user)
                        }
                }
        })
        Publishers.MergeMany(nftsUsers$).collect()
            .zip(profileService.getProfile(id: "1"))
            .map { (nftUsers: [(NFT, User)], profile: Profile) in
                nftUsers.map { (nftUser: (NFT, User)) in
                    MyNFTDisplayModel(nft: nftUser.0, isLike: profile.likes.contains(nftUser.0.id), author: nftUser.1.name)
                }
            }
            .replaceError(with: [])
            .sink { [weak self] nfts in
                self?.state = .loaded
                self?.nftDisplayModels = nfts
            }
            .store(in: &subscriptions)
        
//        let bar$ = Publishers.MergeMany(
//            nftIds.map(nftService.getNFT)
//                .map { (foo: AnyPublisher<NFT, Error>) in
//                    foo.map { (nft: NFT) in
//                        self.userService.getUser(id: nft.author)
//                            .map { (user: User) in
//                                (nft, user)
//                            }
//                            .eraseToAnyPublisher()
//                    }
//                    .eraseToAnyPublisher()
//                }
//        )
//        .collect()
//        .eraseToAnyPublisher()
        
//        let nftDisplayModels$ = Publishers.MergeMany(nftIds.map(nftService.getNFT))
//            .flatMap({ nft in
//                self.userService
//                    .getUser(id: nft.author)
//                    .eraseToAnyPublisher()
//                    .map { ($0, nft) }
//            })
        
        
//            .flatMap { (nfts: [NFT]) in
//                let nftAuthors$ = nfts.map { nft in
//                    self.userService
//                        .getUser(id: nft.author)
//                }
//                return Publishers.MergeMany(nftAuthors$).collect().eraseToAnyPublisher()
//            }
/*
        
            .map({ user in
                (nft, user)
            })
            .eraseToAnyPublisher()
*/
    }
}
