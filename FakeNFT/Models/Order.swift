//
//  Order.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 15.11.2023.
//

import Foundation

struct Order: Decodable {
    var nfts: [String]
    var id: String
}
