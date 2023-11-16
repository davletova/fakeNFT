//
//  ListNFTsViewModel.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 14.11.2023.
//

import Combine
import Foundation

struct NFTViewModel {
    var nft: NFT
    var isLike: Bool
    var isOnOrder: Bool
    
    init(nft: NFT, isLike: Bool, isOnOrder: Bool) {
        self.nft = nft
        self.isLike = isLike
        self.isOnOrder = isOnOrder
    }
    
    func getImageURLs() -> [URL] {
        nft.images.compactMap { URL.fromRawString($0) }
    }
}

class ListNFTViewModel: ObservableObject {
    private var nftService: NFTServiceProtocol
    private var profileService: ProfileServiceProtocol
    private var orderService: OrderServiceProtocol
    
    private var likes = Set<String>()
    private var onOrder = Set<String>()
  
    @Published var nfts: [NFTViewModel] = []
    
    init(nftService: NFTServiceProtocol, profileService: ProfileServiceProtocol, orderService: OrderServiceProtocol) {
        self.nftService = nftService
        self.profileService = profileService
        self.orderService = orderService
    }
    
    func loadData(_ nftIds: [String]) {
        let profile$ = profileService.getProfile(id: "1")
        let order$ = orderService.getOrder(id: "1")
        let nfts$ = Publishers.MergeMany(nftIds.map(nftService.getNFT))
            .collect()
        
        Publishers.Zip3(profile$, order$, nfts$)
            .map { profile, ord, nfts in
                nfts.map { nft in
                    NFTViewModel(nft: nft, isLike: profile.likes.contains(nft.id), isOnOrder: ord.nfts.contains(nft.id))
                }
            }
            .replaceError(with: [NFTViewModel]())
            .assign(to: &$nfts)
    }
}
