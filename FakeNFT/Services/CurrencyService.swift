//
//  CurrencyService.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 05.12.2023.
//

import Foundation
import Combine

enum CurrenciesServiceError : Error {
    case invalidURL
    case invalidResponse
    case requestFailed(Int)
}

protocol CurrencyServiceProtocol {
    func listCurrencies() -> AnyPublisher<[Currency], Error>
}

class CurrencyService: CurrencyServiceProtocol {
    let listCurrenciesPath = "/api/v1/currencies"
    
    func listCurrencies() -> AnyPublisher<[Currency], Error> {
        guard let req = URLRequest.makeHTTPRequest(
            baseUrl: baseURL,
            path: listCurrenciesPath,
            method: HTTPMehtod.get
        ) else {
            return Fail(error: CurrenciesServiceError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: req)
            .map(\.data)
            .decode(type: [Currency].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
