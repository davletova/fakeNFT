//
//  ListNFTViewModel.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 22.11.2023.
//

import Foundation
import SwiftUI
import Combine

struct NFTDisplayModel: Identifiable {
    var nft: NFT
    var isLike: Bool
    var isOnOrder: Bool
   
    var id: String { nft.id }
    
    func getImageURLs() -> [URL] {
        nft.images.compactMap { URL.fromRawString($0) }
    }
}

class ListNFTViewModel: ObservableObject {
    private var nftService: NFTServiceProtocol
    private var profileService: ProfileServiceProtocol
    private var orderService: OrderServiceProtocol
    
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var nftDisplayModels: [NFTDisplayModel] = []
    @Published var state: StateFoo
    
    init(nfts: [String], nftService: NFTServiceProtocol, profileService: ProfileServiceProtocol, orderService: OrderServiceProtocol) {
        self.nftService = nftService
        self.profileService = profileService
        self.orderService = orderService
        
        self.state = .loading
        self.loadData(nfts)
    }
    
    func loadData(_ nftIds: [String]) {
        let profile$ = profileService.getProfile(id: "1")
        let order$ = orderService.getOrder(id: "1")
        let nfts$ = Publishers.MergeMany(nftIds.map(nftService.getNFT)).collect()
        
        Publishers.Zip3(profile$, order$, nfts$)
            .print("----", to: nil)
            .map { profile, ord, nfts in
                nfts.map { nft in
                    NFTDisplayModel(nft: nft, isLike: profile.likes.contains(nft.id), isOnOrder: ord.nfts.contains(nft.id))
                }
            }
            .mapError { [weak self] err in
                self?.state = .failed(err)
                return err
            }
            .replaceError(with: [NFTDisplayModel]())
        //            .assign(to: &$nfts)
            .sink { [weak self] nfts in
                self?.nftDisplayModels = nfts
                self?.state = .loaded
            }
            .store(in: &subscriptions)
    }
}
