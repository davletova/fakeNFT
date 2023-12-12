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
    func getProfile() -> AnyPublisher<Profile, Error>
    func getProfileNFTs() -> AnyPublisher<[NFT], Error>
    func getProfileLikeNFTs() -> AnyPublisher<[NFT], Error>
    func updateProfile(_ updateProfile: Profile) -> AnyPublisher<Void, Error> 
}

final class ProfileService: ProfileServiceProtocol {
    let getUserPath = "/api/v1/profile"
    let getProfileNFTPath = "api/v1/profile/nfts"
    let getProfileLikeNFTPath = "api/v1/profile/likes"
    let updateProfilePath = "api/v1/profile"
    
    func getProfile() -> AnyPublisher<Profile, Error> {
        guard let req = URLRequest.makeHTTPRequest(
            baseUrl: baseURL,
            path: getUserPath,
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
    
    func getProfileNFTs() -> AnyPublisher<[NFT], Error> {
        guard let req = URLRequest.makeHTTPRequest(
            baseUrl: baseURL,
            path: getProfileNFTPath,
            method: HTTPMehtod.get
        ) else {
            return Fail(error: ProfileServiceError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: req)
            .map(\.data)
            .decode(type: [NFT].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func getProfileLikeNFTs() -> AnyPublisher<[NFT], Error> {
        guard let req = URLRequest.makeHTTPRequest(
            baseUrl: baseURL,
            path: getProfileLikeNFTPath,
            method: HTTPMehtod.get
        ) else {
            return Fail(error: ProfileServiceError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: req)
            .map(\.data)
            .decode(type: [NFT].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func updateProfile(_ updateProfile: Profile) -> AnyPublisher<Void, Error> {
        guard let req = URLRequest.makeHTTPRequest(
            baseUrl: baseURL,
            path: updateProfilePath,
            method: HTTPMehtod.put,
            body: updateProfile
        ) else {
            return Fail(error: ProfileServiceError.invalidURL)
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
