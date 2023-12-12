import Foundation
import SwiftUI
import Combine

class ListNFTCollectionViewModel: ObservableObject {
    private var nftService: NFTServiceProtocol
    private var profileService: ProfileServiceProtocol
    
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var nftDisplayModels: [NFTDisplayModel] = []
    @Published var state: StateFoo
    
    init(nftIds: [Int], nftService: NFTServiceProtocol, profileService: ProfileServiceProtocol) {
        self.nftService = nftService
        self.profileService = profileService
        
        self.state = .loading
        self.loadData(nftIds)
    }
    
    func loadData(_ nftIds: [Int]) {
        let likes$ = profileService.getProfileLikeNFTs()
        let myNft$ = profileService.getProfileNFTs()
        let nfts$ = Publishers.MergeMany(nftIds.map(nftService.getNFT)).collect()
                
        nfts$
            .sink { completion in
                if case .failure(let error) = completion {
                    print("----- getProfileLikeNFTs failed: \(error)")
                }
            } receiveValue: { cartLines in
                print("----- getProfileLikeNFTs success: \(cartLines.count)")
            }
            .store(in: &subscriptions)
        
        
        Publishers.Zip3(likes$, myNft$, nfts$)
            .map { likes, my, nfts in
                let likesNftIds = Set(likes.map { $0.id } )
                let cartNftIds = Set(my.map { $0.id } )
                
                return nfts.map { nft in
                    NFTDisplayModel(nft: nft, isLike: likesNftIds.contains(nft.id), isOnOrder: cartNftIds.contains(nft.id))
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
