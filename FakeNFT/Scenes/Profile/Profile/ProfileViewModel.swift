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
    @Published var name: String = ""
    @Published var desc: String = ""
    @Published var website: String = ""
    @Published var nameIsValid = true
    
    var isUserNameValidPublisher: AnyPublisher<Bool, Never> {
        $name
            .map { name in
                return name.count > 0
            }
            .eraseToAnyPublisher()
    }
    
    init(service: ProfileServiceProtocol) {
        self.service = service
        self.state = .loading
        
        self.loadData()
        
        isUserNameValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.nameIsValid, on: self)
            .store(in: &subscriptions)
    }
    
    func updateProfile() {
        profile?.profile.name = name
        profile?.profile.description = desc
        profile?.profile.website = website
        
        let updateProfile = profile!.profile
        
        service.updateProfile(updateProfile)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
//                    self.profile.profile = updateProfile
                    self.name = updateProfile.name
                    print("Request completed successfully.")
                case .failure(let error):
                    print("Request failed with error: \(error)")
                }
            }, receiveValue: {
                print("Request completed without returning a value.")
            })
            .store(in: &subscriptions)
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
                self?.name = profileDisplayModel.profile.name
                self?.desc = profileDisplayModel.profile.description
                self?.website = profileDisplayModel.profile.website
                self?.state = .loaded
            }
            .store(in: &subscriptions)
    }

    private func onReceiveC(_ completion: Subscribers.Completion<Error>) {}
}
