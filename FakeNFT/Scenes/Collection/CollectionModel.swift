//
//  Collection.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 09.11.2023.
//

import Foundation

struct Collection: Codable {
    var name: String
    var cover: String
    var nfts: [String]
    var description: String
    var author: String
    var id: String
}

struct CollectionViewModel {
    var name: String
    var cover: URL
    var nfts: [String]
    var description: String
    var author: String
    var id: String
}
