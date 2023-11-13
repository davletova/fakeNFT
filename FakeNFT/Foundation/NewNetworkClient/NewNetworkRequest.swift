import Foundation

enum NewHttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol NewNetworkRequest {
    var endpoint: URL? { get }
    var httpMethod: HttpMethod { get }
    var dto: Encodable? { get }
}

// default values
extension NewNetworkRequest {
    var httpMethod: HttpMethod { .get }
    var dto: Encodable? { nil }
}
