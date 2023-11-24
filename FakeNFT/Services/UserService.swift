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
    
    func getUser(id: String) -> AnyPublisher<User, Error>
}

final class UserService: UserServiceProtocol {
    private var listUserPath = "/api/v1/users"
    private var getUserPath = "/api/v1/users"
    
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
            return Fail(error: UserServiceError.invalidURL)
                .eraseToAnyPublisher()
        }
        return URLSession.shared
            .dataTaskPublisher(for: req)
            .map(\.data)
            .decode(type: [User].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func getUser(id: String) -> AnyPublisher<User, Error> {
        guard let req = URLRequest.makeHTTPRequest(
            baseUrl: baseURL,
            path: getUserPath + "/" + id,
            method: HTTPMehtod.get
        ) else {
            return Fail(error: UserServiceError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: req)
            .map(\.data)
            .decode(type: User.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
