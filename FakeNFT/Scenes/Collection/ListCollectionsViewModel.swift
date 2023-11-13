//
//  ViewModal.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 09.11.2023.
//

import Combine
import Foundation

enum ListCollectionsSortParameter: String {
    case byName = "name"
    case byAuthor = "author"
    case byID = "id"
}

enum ListCollectionsSortOrder: String {
    case asc = "asc"
    case desc = "desc"
}

class ListCollectionsViewModel: ObservableObject {
    @Published var collections = [CollectionViewModel]()
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        let publisher = URLSession.shared
            .dataTaskPublisher(for: URL(string:  "/api/v1/collections", relativeTo: baseURL)!)
            .map(\.data)
            .decode(type: [Collection].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
                
    func getCollections() {
        service.listCollections(
            perPage: collectionsPerPage,
            nextPage: page,
            sortParameter: ListCollectionsSortParameter.byName,
            sortOrder: ListCollectionsSortOrder.asc
        ) { [weak self] (result: Result<[Collection], Error>) in
            guard let self = self else {
                assertionFailure("self is empty")
                return
            }
            
            switch result {
            case .failure(let error):
                print("failed to list collections: \(error)")
                return
            case .success(let collections):
                for collection in collections {
                    if let collectionVM = collectionTocollectionVM(from: collection) {
                        self.collections.append(collectionVM)
                    }
                }
            }
        }
    }
    
    private func collectionTocollectionVM(from collection: Collection) -> CollectionViewModel? {
        guard let str = collection.cover.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
              let url = URL(string: str)
        else {
            print("failed to create url from \(collection.cover)")
            return nil
        }
        
        return CollectionViewModel(
            name: "\(collection.name) (\(collection.nfts.count))",
            cover: url,
            nfts: collection.nfts,
            description: collection.description,
            author: collection.author,
            id: collection.id
        )
    }
}
