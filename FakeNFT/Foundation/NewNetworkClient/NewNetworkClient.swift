import Foundation
import Combine

enum NewNetworkClientError: Error {
    case httpStatusCode(Int)
    case urlRequestError(Error)
    case urlSessionError
    case parsingError
}

protocol NewNetworkClient {
    func send<T: Decodable>(request: URLRequest) -> AnyPublisher<T, Error>
}

struct NewDefaultNetworkClient: NewNetworkClient {
    @discardableResult
    func send<T: Decodable>(request: URLRequest) -> AnyPublisher<T, Error> {
        URLSession.shared
            .dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
