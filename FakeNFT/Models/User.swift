//
//  Model.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 13.11.2023.
//

import Foundation

struct User: Decodable, Equatable {
    var name: String
    var avatar: String
    var description: String
    var website: String
    var rating: Int
    var id: Int
}
