import Foundation
import SwiftUI

struct ListNFTCollectionView: View {
    private var minNFTWidrh: CGFloat = 100
    @ObservedObject var viewModel: ListNFTCollectionViewModel
    
    init(viewModel: ListNFTCollectionViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: minNFTWidrh))], spacing: 28) {
                ForEach(viewModel.nftDisplayModels) { nft in
                    NFTItemView(
                        viewModel: NftCollectionItemViewModel(
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

struct ListNFTCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        ListNFTCollectionView(
            viewModel: ListNFTCollectionViewModel(
                nftIds: [2, 5, 6, 7, 9],
                nftService: NFTService(),
                profileService: ProfileService(),
                cartService: CartService()
            )
        )
    }
}
