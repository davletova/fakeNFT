import Foundation

protocol NewNetworkTask {
    func cancel()
}

struct NewDefaultNetworkTask: NewNetworkTask {
    let dataTask: URLSessionDataTask

    func cancel() {
        dataTask.cancel()
    }
}
