//
//  ProfileService.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 15.11.2023.
//

import Foundation
import Combine

enum ProfileServiceError: Error {
    case invalidURL
}

protocol ProfileServiceProtocol {
    func getProfile(id: String) -> AnyPublisher<Profile, Error>
}

final class ProfileService: ProfileServiceProtocol {
    let getUserPath = "/api/v1/profile"
    
    func getProfile(id: String) -> AnyPublisher<Profile, Error> {
        guard let req = URLRequest.makeHTTPRequest(
            baseUrl: baseURL,
            path: getUserPath + "/" + id,
            method: HTTPMehtod.get
        ) else {
            return Fail(error: ProfileServiceError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: req)
            .map(\.data)
            .decode(type: Profile.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
