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
    case invalidResponse
    case requestFailed(Int)
}

protocol NFTServiceProtocol {
    func getNFT(_ id: Int) -> AnyPublisher<NFT, Error>
    func likeNft(_ id: Int) -> AnyPublisher<Void, Error>
    func unlikeNft(_ id: Int) -> AnyPublisher<Void, Error>
}


class NFTService: NFTServiceProtocol {
    let getNFTPath = "/api/v1/nfts"
    
    func getNFT(_ id: Int) -> AnyPublisher<NFT, Error> {
        guard let req = URLRequest.makeHTTPRequest(
            baseUrl: baseURL,
            path: getNFTPath + "/" + id.description,
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
    
    func likeNft(_ id: Int) -> AnyPublisher<Void, Error> {
        guard let req = URLRequest.makeHTTPRequest(
            baseUrl: baseURL,
            path: "api/v1/nfts/\(id)/like",
            method: HTTPMehtod.post
        ) else {
            return Fail(error: NFTServiceError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: req)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NFTServiceError.invalidResponse
                }

                guard (200...299).contains(httpResponse.statusCode) else {
                    throw NFTServiceError.requestFailed(httpResponse.statusCode)
                }

                return
            }
            .mapError { error in
                // Handle any additional error cases if needed
                error
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func unlikeNft(_ id: Int) -> AnyPublisher<Void, Error> {
        guard let req = URLRequest.makeHTTPRequest(
            baseUrl: baseURL,
            path: "api/v1/nfts/\(id)/unlike",
            method: HTTPMehtod.post
        ) else {
            return Fail(error: NFTServiceError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: req)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NFTServiceError.invalidResponse
                }

                guard (200...299).contains(httpResponse.statusCode) else {
                    throw NFTServiceError.requestFailed(httpResponse.statusCode)
                }

                return
            }
            .mapError { error in
                // Handle any additional error cases if needed
                error
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
