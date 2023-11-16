//
//  CollectionService.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 09.11.2023.
//

import Foundation
import Combine

enum CollectionServiceError: Error {
    case invalidURL
}

protocol CollectionServiceProtocol {
    func listCollections(
        perPage: Int,
        nextPage: Int,
        sortParameter: ListCollectionsSortParameter,
        sortOrder: ListCollectionsSortOrder
    ) -> AnyPublisher<[Collection], Error>
    
    func getCollection(id: String) -> AnyPublisher<Collection, Error>
}

class CollectionService: CollectionServiceProtocol {
    private let getCollectionPath = "/api/v1/collections"
    private let listCollectionPath = "/api/v1/collections"
    
    func listCollections(
        perPage: Int,
        nextPage: Int,
        sortParameter: ListCollectionsSortParameter,
        sortOrder: ListCollectionsSortOrder
    ) -> AnyPublisher<[Collection], Error> {
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "sortBy", value: sortParameter.rawValue),
            URLQueryItem(name: "order", value: sortOrder.rawValue),
            URLQueryItem(name: "page", value: nextPage.description),
            URLQueryItem(name: "limit", value: perPage.description)
        ]
        
        guard let req = URLRequest.makeHTTPRequest(
            baseUrl: baseURL,
            path: listCollectionPath,
            method: HTTPMehtod.get,
            queryItems: queryItems
        ) else {
            return Fail(error: CollectionServiceError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: req)
            .map(\.data)
            .decode(type: [Collection].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func getCollection(id: String) -> AnyPublisher<Collection, Error> {
        guard let req = URLRequest.makeHTTPRequest(
            baseUrl: baseURL,
            path: getCollectionPath,
            method: HTTPMehtod.get
        ) else {
            return Fail(error: CollectionServiceError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: req)
            .map(\.data)
            .decode(type: Collection.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
