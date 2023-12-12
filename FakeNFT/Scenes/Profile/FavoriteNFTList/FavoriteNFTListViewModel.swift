import Foundation
import SwiftUI
import Combine

class FavoriteNFTListViewModel: ObservableObject {
    private var nftService: NFTServiceProtocol
    private var profileService: ProfileServiceProtocol
    
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var nftDisplayModels: [NFTDisplayModel] = []
    @Published var state: StateFoo
    
    init(nftService: NFTServiceProtocol, profileService: ProfileServiceProtocol) {
        self.nftService = nftService
        self.profileService = profileService
        
        self.state = .loading
        self.loadData()
    }
    
    func loadData() {
        let likes$ = profileService.getProfileLikeNFTs()
        let my$ = profileService.getProfileNFTs()
        
        Publishers.Zip(likes$, my$)
            .map { likes, cart in
                let myNftIds = Set(cart.map { $0.id } )
                return likes.map { nft in
                    NFTDisplayModel(nft: nft, isLike: true, isOnOrder: myNftIds.contains(nft.id))
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
