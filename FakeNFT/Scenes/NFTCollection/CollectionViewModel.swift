//
//  CollectionViewModel.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 14.11.2023.
//

import Foundation
import Combine

//TODO: это общее перечисление, надо переместить
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



class CollectionViewModel: ObservableObject {
    var collection: SingleCollectionDisplayModel
    
    init(collection: Collection) {
        self.collection = SingleCollectionDisplayModel(collection: collection)
      
//        self.state = .loading
//        loadData(collection.nfts)
    }
    
//    func loadData(_ nftIds: [String]) {
//        let profile$ = profileService.getProfile(id: "1")
//        let order$ = orderService.getOrder(id: "1")
//        let nfts$ = Publishers.MergeMany(nftIds.map(nftService.getNFT)).collect()
//        
//        Publishers.Zip3(profile$, order$, nfts$)
//            .print("----", to: nil)
//            .map { profile, ord, nfts in
//                nfts.map { nft in
//                    NFTDisplayModel(nft: nft, isLike: profile.likes.contains(nft.id), isOnOrder: ord.nfts.contains(nft.id))
//                }
//            }
//            .mapError { [weak self] err in
//                self?.state = .failed(err)
//                return err
//            }
//            .replaceError(with: [NFTDisplayModel]())
////            .assign(to: &$nfts)
//            .sink { [weak self] nfts in
//                self?.nfts = nfts
//                self?.state = .loaded
//            }
//            .store(in: &subscriptions)
//    }
}
