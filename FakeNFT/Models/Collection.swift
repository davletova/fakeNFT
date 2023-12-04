//
//  Collection.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 09.11.2023.
//

import Foundation

struct Collection: Codable, Hashable {
    var name: String
    var cover: String
    var nfts: [Int]
    var description: String
    var author: Int
    var id: Int
}

