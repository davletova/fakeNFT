import Foundation
import Combine

struct ProfileDisplayModel {
    var profile: Profile
    
    var nfts: [NFT]
    var likes: [NFT]
    
    func getAvatarURL() -> URL? {
        URL.fromRawString(profile.avatar)
    }
    
    func getWebsiteURL() -> URL? {
        URL.fromRawString(profile.website)
    }
}

class ProfileViewModel: ObservableObject {
    private var service: ProfileServiceProtocol
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var profile: ProfileDisplayModel?
    @Published var state: StateFoo
    
    init(service: ProfileServiceProtocol) {
        self.service = service
        self.state = .loading
        self.loadData()
    }
    
    func loadData() {
        let profile$ = service.getProfile()
        let nfts$ = service.getProfileNFTs()
        let likes$ = service.getProfileLikeNFTs()
        
        Publishers.Zip3(profile$, nfts$, likes$)
            .map { profile, nfts, likes in
                ProfileDisplayModel(profile: profile, nfts: nfts, likes: likes)
            }
            .mapError { [weak self] err in
                    self?.state = .failed(err)
                    return err
            }
            .sink(receiveCompletion: onReceiveC) { [weak self] (profileDisplayModel: ProfileDisplayModel) in
                self?.profile = profileDisplayModel
                self?.state = .loaded
            }
            .store(in: &subscriptions)
    }

    private func onReceiveC(_ completion: Subscribers.Completion<Error>) {}
}
