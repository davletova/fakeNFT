//
//  ViewModal.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 09.11.2023.
//

import Foundation
import Combine

enum ListCollectionsSortParameter: String {
    case byName = "name"
    case byAuthor = "author"
    case byID = "id"
}

enum ListCollectionsSortOrder: String {
    case asc = "asc"
    case desc = "desc"
}

struct CollectionDisplayModel: Identifiable, Equatable, Hashable {
    var collection: Collection
    
    var id: String {
        collection.id
    }
    
    func getCoverURL() -> URL? {
        URL.fromRawString(collection.cover)
    }
}

class ListCollectionsViewModel: ObservableObject {
    private var service: CollectionServiceProtocol
    private let collectionsPerPage = 20
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var collections: [CollectionDisplayModel] = []
    @Published var state: StateFoo
    
    var page = 1
    var canLoadNextPage = true

    var sortParameter: ListCollectionsSortParameter = .byName
    var sortOrder: ListCollectionsSortOrder = .asc
    
    init(service: CollectionServiceProtocol) {
        self.service = service
        
        self.state = .loading
        
        self.fetchNextPageIfPossible()
    }
    
    func fetchNextPageIfPossible() {
        guard canLoadNextPage else { return }
        
        service.listCollections(perPage: collectionsPerPage, nextPage: page, sortParameter: sortParameter, sortOrder: sortOrder)
//            .print("---------", to: nil)
            .mapError { [weak self] err in
                self?.state = .failed(err)
                return err
            }
            .map { collections in
                collections.map { CollectionDisplayModel(collection: $0) }
            }
            .sink(receiveCompletion: onReceiveC,
                  receiveValue: onReceive)
            .store(in: &subscriptions)
    }
    
    private func onReceiveC(_ completion: Subscribers.Completion<Error>) {
        if case .failure(_) = completion {
            canLoadNextPage = false
        }
    }
    
    private func onReceive(_ batch: [CollectionDisplayModel]) {
        state = .loaded
        collections += batch
        page += 1
        canLoadNextPage = batch.count == collectionsPerPage
    }
}
