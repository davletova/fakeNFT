//
//  UserService.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 13.11.2023.
//

import Foundation
import Combine

enum UserServiceError: Error {
    case invalidURL
}

protocol UserServiceProtocol {
    func listUser(
        usersPerPage: Int,
        nextPage: Int,
        sortParameter: UsersSortParameter,
        sortOrder: UsersSortOrder
    ) -> AnyPublisher<[User], Error>
}

final class UserService: UserServiceProtocol {
    private var listUserPath = "/api/v1/users"
    
    let networkClient: NewNetworkClient
    
    init(networkClient: NewNetworkClient) {
        self.networkClient = networkClient
    }
    
    func listUser(
        usersPerPage: Int,
        nextPage: Int,
        sortParameter: UsersSortParameter,
        sortOrder: UsersSortOrder
    ) -> AnyPublisher<[User], Error>  {
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "sortBy", value: sortParameter.rawValue),
            URLQueryItem(name: "order", value: sortOrder.rawValue),
            URLQueryItem(name: "page", value: nextPage.description),
            URLQueryItem(name: "limit", value: usersPerPage.description)
        ]
        
        guard let req = URLRequest.makeHTTPRequest(
            baseUrl: baseURL,
            path: listUserPath,
            method: HTTPMehtod.get,
            queryItems: queryItems
        ) else {
            print("failed to create request")
            return Fail(error: UserServiceError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        return networkClient.send(request: req)
    }
}
