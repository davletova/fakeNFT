//
//  ViewModal.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 09.11.2023.
//

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
    private var service: CollectionServiceProtocol
    private let collectionsPerPage = 20
    
    @Published var collections: [CollectionViewModel] = []
    
    var page = 1
    
    init(service: CollectionServiceProtocol) {
        self.service = service
        self.getCollections()
    }
    
    func loadMoreContent(currentItem item: CollectionViewModel) {
        if let lastID = Int(item.id), self.collections.endIndex == lastID {
            print("lastID =\(lastID), endInd = \(self.collections.endIndex), page=\(page)")
            page += 1
            getCollections()
        }
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
                        DispatchQueue.main.async {
                            self.collections.append(collectionVM)
                        }
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
