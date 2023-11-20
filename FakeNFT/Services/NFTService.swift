//
//  NFTService.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 15.11.2023.
//

import Foundation
import Combine

enum NFTServiceError : Error {
    case invalidURL
}

protocol NFTServiceProtocol {
    func getNFT(_ id: String) -> AnyPublisher<NFT, Error>
}


class NFTService: NFTServiceProtocol {
    let getNFTPath = "/api/v1/nft"
    
    func getNFT(_ id: String) -> AnyPublisher<NFT, Error> {
        guard let req = URLRequest.makeHTTPRequest(
            baseUrl: baseURL,
            path: getNFTPath + "/" + id,
            method: HTTPMehtod.get
        ) else {
            return Fail(error: NFTServiceError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: req)
            .map(\.data)
            .decode(type: NFT.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
