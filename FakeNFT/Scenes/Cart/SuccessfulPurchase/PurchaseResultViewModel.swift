//
//  SuccessfulPurchaseViewModel.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 11.12.2023.
//

import Foundation
import Combine

class PurchaseResultViewModel {
    var nft: CartNFTDisplayModel
    var service: CartServiceProtocol
    
    @Published var state: StateFoo
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(nft: CartNFTDisplayModel, service: CartServiceProtocol) {
        self.nft = nft
        self.service = service
        state = .loading
        
        loadData()
    }
    
    func loadData() {
            service.checkout()
                .print("-----", to: nil)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        self.state = .loaded
                        print("Request completed successfully.")
                    case .failure(let error):
                        self.state = .failed(error)
                        print("Request failed with error: \(error)")
                    }
                }, receiveValue: {
                    print("Request completed without returning a value.")
                })
                .store(in: &subscriptions)
        
    }
}
