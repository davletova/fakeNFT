//
//  NFTModel.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 14.11.2023.
//

import Foundation

struct NFT: Decodable {
    var createdAt: String
    var name: String
    var images: [String]
    var rating: Int
    var description: String
    var price: Float
    var author: String
    var id: String
}
