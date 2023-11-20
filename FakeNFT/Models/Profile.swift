//
//  Profile.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 15.11.2023.
//

import Foundation

struct Profile: Decodable {
    var name: String
    var avatar: String
    var description: String
    var website: String
    var nfts: [String]
    var likes: [String]
    var id: String
}
