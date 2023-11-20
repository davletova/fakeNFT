//
//  CollectionViewModel.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 14.11.2023.
//

import Foundation
import Combine

enum StateFoo {
    case loading
    case failed(Error)
    case loaded
}

struct SingleCollectionDisplayModel {
    var collection: Collection
    
    func getCoverURL() -> URL {
        URL.fromRawString(collection.cover)
    }
}

struct NFTDisplayModel: Identifiable {
    var nft: NFT
    var isLike: Bool
    var isOnOrder: Bool
   
    var id: String { nft.id }
    
    func getImageURLs() -> [URL] {
        nft.images.compactMap { URL.fromRawString($0) }
    }
}

class CollectionViewModel: ObservableObject {
    private var nftService: NFTServiceProtocol
    private var profileService: ProfileServiceProtocol
    private var orderService: OrderServiceProtocol
    
    private var likes = Set<String>()
    private var onOrder = Set<String>()
    
    private var subscriptions = Set<AnyCancellable>()

    var collection: SingleCollectionDisplayModel
    
    @Published var nfts: [NFTDisplayModel] = []
    @Published var state: StateFoo
    
    init(collection: Collection, nftService: NFTServiceProtocol, profileService: ProfileServiceProtocol, orderService: OrderServiceProtocol) {
        self.nftService = nftService
        self.profileService = profileService
        self.orderService = orderService
        
        self.collection = SingleCollectionDisplayModel(collection: collection)
        
        self.state = .loading
        loadData(collection.nfts)
    }
    
    func loadData(_ nftIds: [String]) {
        let profile$ = profileService.getProfile(id: "1")
        let order$ = orderService.getOrder(id: "1")
        let nfts$ = Publishers.MergeMany(nftIds.map(nftService.getNFT)).collect()
        
        Publishers.Zip3(profile$, order$, nfts$)
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
                self?.nfts = nfts
                self?.state = .loaded
            }
            .store(in: &subscriptions)
    }
}
