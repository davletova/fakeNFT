//
//  NFTDisplayModel.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 29.11.2023.
//

import Foundation

struct NFTDisplayModel: Identifiable {
    var nft: NFT
    var isLike: Bool
    var isOnOrder: Bool
   
    var id: Int { nft.id }
    
    func getImageURLs() -> [URL] {
        nft.images.compactMap { URL.fromRawString($0) }
    }
}

