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
    
    var id: String { nft.id }
    
    func getImageURLs() -> [URL] {
        nft.images.compactMap { URL.fromRawString($0) }
    }
}

class CartViewModel: ObservableObject {
    private var nftService: NFTService
    private var orderService: OrderService
    
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var cartNFTDisplayModels: [CartNFTDisplayModel] = []
    @Published var state: StateFoo
    
    init(nftService: NFTService, orderService: OrderService) {
        self.nftService = nftService
        self.orderService = orderService
        
        self.state = .loading
        loadData()
    }
        
    func loadData() {
        orderService.getOrder(id: "1")
            .flatMap { (order: Order) in
                Publishers.MergeMany(order.nfts.map(self.nftService.getNFT)).collect()
            }
            .map { $0.map(CartNFTDisplayModel.init) }
            .replaceError(with: [])
            .sink { nfts in
                self.state = .loaded
                self.cartNFTDisplayModels = nfts
            }
            .store(in: &subscriptions)
    }
}
