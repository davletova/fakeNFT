//
//  OrderService.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 15.11.2023.
//

import Foundation
import Combine

enum CartServiceError: Error {
    case invalidURL
}

protocol CartServiceProtocol {
    func getCart() -> AnyPublisher<[CartLine], Error>
    func addNft(_ id: Int) -> AnyPublisher<Void, Error>
    func deleteNft(_ id: Int) -> AnyPublisher<Void, Error>
}

final class CartService: CartServiceProtocol {
    private var getCartPath = "/api/v1/cart"
    private var addNftPath = "/api/v1/cart"
    private var deleteNftPath = "/api/v1/cart"
    
    func getCart() -> AnyPublisher<[CartLine], Error> {
        guard let req = URLRequest.makeHTTPRequest(
            baseUrl: baseURL,
            //TODO: подумать что тут за id должно быть
            path: getCartPath,
            method: HTTPMehtod.get
        ) else {
            return Fail(error: CartServiceError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: req)
            .map(\.data)
            .decode(type: [CartLine].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func addNft(_ id: Int) -> AnyPublisher<Void, Error> {
        guard let req = URLRequest.makeHTTPRequest(
            baseUrl: baseURL,
            //TODO: подумать что тут за id должно быть
            path: addNftPath,
            method: HTTPMehtod.put,
            body: CartLine(nftId: id)
        ) else {
            return Fail(error: CartServiceError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: req)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NFTServiceError.invalidResponse
                }

                guard (200...299).contains(httpResponse.statusCode) else {
                    print("----- \(String(data: data, encoding: .utf8))")
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
    
    func deleteNft(_ id: Int) -> AnyPublisher<Void, Error> {
        guard let req = URLRequest.makeHTTPRequest(
            baseUrl: baseURL,
            //TODO: подумать что тут за id должно быть
            path: deleteNftPath,
            method: HTTPMehtod.delete,
            body: CartLine(nftId: id)
        ) else {
            return Fail(error: CartServiceError.invalidURL)
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
