import Foundation
import SwiftUI
import Combine

class FavoriteNFTListViewModel: ObservableObject {
    private var nftService: NFTServiceProtocol
    private var profileService: ProfileServiceProtocol
    private var cartService: CartServiceProtocol
    
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var nftDisplayModels: [NFTDisplayModel] = []
    @Published var state: StateFoo
    
    init(nftService: NFTServiceProtocol, profileService: ProfileServiceProtocol, orderService: CartServiceProtocol) {
        self.nftService = nftService
        self.profileService = profileService
        self.cartService = orderService
        
        self.state = .loading
        self.loadData()
    }
    
    func loadData() {
        let likes$ = profileService.getProfileLikeNFTs()
        let cart$ = cartService.getCart()
        
        Publishers.Zip(likes$, cart$)
            .map { likes, cart in
                let cartNftIds = Set(cart.map { $0.nftId } )
                
                return likes.map { nft in
                    NFTDisplayModel(nft: nft, isLike: true, isOnOrder: cartNftIds.contains(nft.id))
                }
            }
            .mapError { [weak self] err in
                self?.state = .failed(err)
                return err
            }
            .replaceError(with: [NFTDisplayModel]())
        //            .assign(to: &$nfts)
            .sink { [weak self] nfts in
                self?.nftDisplayModels = nfts
                self?.state = .loaded
            }
            .store(in: &subscriptions)
    }
}
