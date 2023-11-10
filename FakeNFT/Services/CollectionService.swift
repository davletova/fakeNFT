//
//  CollectionService.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 09.11.2023.
//

import Foundation

protocol CollectionServiceProtocol {
    func listCollections(
        perPage: Int,
        nextPage: Int,
        sortParameter: CollectionsSortParameter,
        sortOrder: CollectionsSortOrder,
        _ handler: @escaping(Result<[Collection], Error>) -> Void
    )
}

struct ListCollectionsRequest: NetworkRequest {
    private var path = "/api/v1/collections"
    
    var endpoint: URL?
    
    init(nextPage: Int, perPage: Int, sortParameter: CollectionsSortParameter, sortOrder: CollectionsSortOrder) {
        guard let url = URL(string: path, relativeTo: baseURL) else {
            assertionFailure("failed to create url from baseURL: \(String(describing: baseURL?.absoluteString)), path: \(path)")
            return
        }
        
        var urlComponents = URLComponents(string: url.absoluteString)
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "sortBy", value: sortParameter.rawValue),
            URLQueryItem(name: "order", value: sortOrder.rawValue),
            URLQueryItem(name: "page", value: nextPage.description),
            URLQueryItem(name: "limit", value: perPage.description)
        ]
        
        urlComponents?.queryItems = queryItems
        
        endpoint = urlComponents?.url
    }
}

class CollectionService: CollectionServiceProtocol {
    let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func listCollections(
        perPage: Int,
        nextPage: Int,
        sortParameter: CollectionsSortParameter,
        sortOrder: CollectionsSortOrder,
        _ handler: @escaping(Result<[Collection], Error>) -> Void
    ) {
        let req = ListCollectionsRequest(nextPage: nextPage, perPage: perPage, sortParameter: sortParameter, sortOrder: sortOrder)
        
        networkClient.send(request: req, type: [Collection].self, onResponse: handler)
    }
}
