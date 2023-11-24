//
//  ListNFTsView.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 14.11.2023.
//

import Foundation
import SwiftUI

struct ListNFTView: View {
    private var minNFTWidrh: CGFloat = 100
    @ObservedObject var viewModel: ListNFTViewModel
    
    init(viewModel: ListNFTViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: minNFTWidrh))], spacing: 28) {
                ForEach(viewModel.nftDisplayModels) { nft in
                    NFTItemView(nft: nft)
                }
            }
            .padding(.trailing, 16)
        }
        .padding(.leading, 16)
    }
}

struct ListNFTView_Previews: PreviewProvider {
    static var previews: some View {
        ListNFTView(
            viewModel: ListNFTViewModel(
                nfts: ["22","30","82","5","85","27","63","62","81","83","32","66","65","25","29","61","60","28","49"],
                nftService: NFTService(),
                profileService: ProfileService(),
                orderService: OrderService()
            )
        )
    }
}
