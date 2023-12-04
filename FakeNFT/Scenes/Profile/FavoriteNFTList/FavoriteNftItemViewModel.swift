import Foundation
import SwiftUI
import Combine

class FavoriteNftItemViewModel: ObservableObject, NftItemViewModelProtocol {
    @Published var nftDisplayModel: NFTDisplayModel
    
    private var nftService: NFTServiceProtocol
    private var profileService: ProfileServiceProtocol
    private var cartService: CartServiceProtocol
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(
        nftDisplayModel: NFTDisplayModel,
        nftService: NFTServiceProtocol,
        profileService: ProfileServiceProtocol,
        orderService: CartServiceProtocol
    ) {
        self.nftDisplayModel = nftDisplayModel
        self.nftService = nftService
        self.profileService = profileService
        self.cartService = orderService
    }
    
    func likeNft(_ id: Int) {
         nftService.likeNft(id)
             .sink(receiveCompletion: { completion in
                 switch completion {
                 case .finished:
                     self.nftDisplayModel.isLike = true
                     print("Request completed successfully.")
                 case .failure(let error):
                     print("Request failed with error: \(error)")
                 }
             }, receiveValue: {
                 print("Request completed without returning a value.")
             })
             .store(in: &subscriptions)
     }
     
     func unlikeNft(_ id: Int) {
         nftService.unlikeNft(id)
             .sink(receiveCompletion: { completion in
                 switch completion {
                 case .finished:
                     self.nftDisplayModel.isLike = false
                     print("Request completed successfully.")
                 case .failure(let error):
                     print("Request failed with error: \(error)")
                 }
             }, receiveValue: {
                 print("Request completed without returning a value.")
             })
             .store(in: &subscriptions)
     }
     
     func addToCart(_ id: Int) {
         cartService.addNft(id)
             .sink(receiveCompletion: { completion in
                 switch completion {
                 case .finished:
                     self.nftDisplayModel.isOnOrder = true
                     print("Request completed successfully.")
                 case .failure(let error):
                     print("Request failed with error: \(error)")
                 }
             }, receiveValue: {
                 print("Request completed without returning a value.")
             })
             .store(in: &subscriptions)
     }
     
     func deleteFromCart(_ id: Int) {
         cartService.deleteNft(id)
             .sink(receiveCompletion: { completion in
                 switch completion {
                 case .finished:
                     self.nftDisplayModel.isOnOrder = false
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

