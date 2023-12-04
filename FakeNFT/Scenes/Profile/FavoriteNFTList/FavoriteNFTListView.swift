import Foundation
import SwiftUI

struct FavoriteNFTListView: View {
    private var minNFTWidrh: CGFloat = 100
    @ObservedObject var viewModel: FavoriteNFTListViewModel
    
    init(viewModel: FavoriteNFTListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: minNFTWidrh))], spacing: 28) {
                ForEach(viewModel.nftDisplayModels) { nft in
                    NFTItemView(
                        viewModel: FavoriteNftItemViewModel(
                            nftDisplayModel: nft,
                            nftService: NFTService(),
                            profileService: ProfileService(),
                            orderService: CartService()
                        )
                    )
                }
            }
        }
    }
}

struct ListNFTView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteNFTListView(
            viewModel: FavoriteNFTListViewModel(
                nftService: NFTService(),
                profileService: ProfileService(),
                orderService: CartService()
                )
        )
    }
}
