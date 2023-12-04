//
//  CollectionViewModel.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 14.11.2023.
//

import Foundation
import Combine

//TODO: это общее перечисление, надо переместить
enum StateFoo {
    case loading
    case failed(Error)
    case loaded
}

struct SingleCollectionDisplayModel {
    var collection: Collection
    
    func getCoverURL() -> URL {
        URL.fromRawString(collection.cover)
    }
}

class CollectionDetailsViewModel: ObservableObject {
    private var userService: UserServiceProtocol
    private var subscriptions = Set<AnyCancellable>()
    
    var collection: SingleCollectionDisplayModel
    
    @Published var author: String = ""
    
    init(collection: Collection, userService: UserServiceProtocol) {
        self.collection = SingleCollectionDisplayModel(collection: collection)
        self.userService = userService
        
        loadAuthor(collection.author)
    }
    
    func loadAuthor(_ id: Int) {
        userService.getUser(id: id)
            .sink { completion in
                if case .failure(let error) = completion {
                    print("get user failed: \(error.localizedDescription)")
                }
            } receiveValue: { user in
                self.author = user.name
            }
            .store(in: &subscriptions)
    }
}
