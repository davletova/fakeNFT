//
//  URL+FromRowString.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 15.11.2023.
//

import Foundation

extension URL {
    static func fromRawString(_ str: String) -> URL {
        str
            .addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
            .flatMap { URL(string: $0) }!
//        URL(string: str.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!)!
    }
}
