//
//  Model.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 13.11.2023.
//

import Foundation

struct User: Decodable {
    var name: String
    var avatar: String
    var description: String
    var website: String
    var nfts: [String]
    var rating: String
    var id: String
}

struct UserVM: Equatable {
    var name: String
    var avatar: URL
    var description: String
    var website: URL
    var nfts: [String]
    var rating: String
    var id: String
}
