//
//  CartViewModel.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 24.11.2023.
//

import Foundation
import Combine

struct CartNFTDisplayModel: Identifiable {
    var nft: NFT
    
    var id: Int { nft.id }
    
    func getImageURLs() -> [URL] {
        nft.images.compactMap { URL.fromRawString($0) }
    }
}

class CartViewModel: ObservableObject {
    private var nftService: NFTService
    private var cartService: CartService
    
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var cartNFTDisplayModels: [CartNFTDisplayModel] = []
    @Published var state: StateFoo
    
    @Published var deleteNFT: CartNFTDisplayModel?
    
    init(nftService: NFTService, cartService: CartService) {
        self.nftService = nftService
        self.cartService = cartService
        
        self.state = .loading
        loadData()
    }
        
    func loadData() {
        cartService.getCart()
            .flatMap { (cartLines: [CartLine]) in
                Publishers.MergeMany(cartLines.map {self.nftService.getNFT($0.nftId) }).collect()
            }
            .map { $0.map(CartNFTDisplayModel.init) }
            .replaceError(with: [])
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            }, receiveValue: {[weak self] nfts in
                self?.state = .loaded
                self?.cartNFTDisplayModels = nfts
            })
            .store(in: &subscriptions)
    }
    
    func deleteItem(item: CartNFTDisplayModel) {
        cartService.deleteNft(item.id)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.cartNFTDisplayModels = self.cartNFTDisplayModels.filter { $0.id != item.id }
                    print("Request completed successfully.")
                case .failure(let error):
                    print("Request failed with error: \(error)")
                }
            }, receiveValue: {
                print("Request completed without returning a value.")
            })
            .store(in: &subscriptions)
    }
}
