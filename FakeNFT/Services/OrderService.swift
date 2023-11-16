//
//  OrderService.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 15.11.2023.
//

import Foundation
import Combine

enum OrderServiceError: Error {
    case invalidURL
}

protocol OrderServiceProtocol {
    func getOrder(id: String) -> AnyPublisher<Order, Error>
}

final class OrderService: OrderServiceProtocol {
    private var getOrderPath = "/api/v1/orders"
    
    func getOrder(id: String) -> AnyPublisher<Order, Error> {
        guard let req = URLRequest.makeHTTPRequest(
            baseUrl: baseURL,
            //TODO: подумать что тут за id должно быть
            path: getOrderPath + "/1",
            method: HTTPMehtod.get
        ) else {
            return Fail(error: OrderServiceError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: req)
            .map(\.data)
            .decode(type: Order.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
