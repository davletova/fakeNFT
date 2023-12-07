//
//  CartItemView.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 24.11.2023.
//

import Foundation
import SwiftUI
import NukeUI

struct CartItemView: View {
    private var nft: CartNFTDisplayModel
    private var viewModel: CartViewModel
    
    init(nft: CartNFTDisplayModel, viewVodel: CartViewModel) {
        self.nft = nft
        self.viewModel = viewVodel
    }
    
    var body: some View {
        HStack {
            LazyImage(url: nft.getImageURLs()[0]) { state in
                if let image = state.image {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 108, height: 108)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(.trailing, 20)
                } else if state.error != nil {
                    Color.red // Indicates an error
                } else {
                    Color.appLightGray
                        .frame(width: 70, height: 70)
                        .padding(.trailing, 16)
                }
            }
            VStack(alignment: .leading) {
                Text(nft.nft.name)
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(Color.appBlack)
                Image("stars\(nft.nft.rating)")
                    .frame(width: 68, height: 12)
                    .padding(.bottom, 4)
                Text("Цена")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(Color.black)
                Text("\(String(format: "%.2f", nft.nft.price)) ETH")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(Color.appBlack)
            }
            Spacer()
            Button (action: { self.viewModel.deleteNFT = nft }) {
                Image("basketCross")
                    .frame(width: 40, height: 40)
            }
        }
    }
}

struct CartItemView_Previews: PreviewProvider {
    static var previews: some View {
        CartItemView(
            nft: CartNFTDisplayModel(
                nft: NFT(
                    createdAt: "",
                    name: "Archie",
                    images: [
                        "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/1.png",
                        "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/2.png",
                        "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/3.png"
                    ],
                    rating: 6,
                    description: "Персиковый — как облака над закатным солнцем в океане. В этой коллекции совмещены трогательная нежность и живая игривость сказочных зефирных зверей.",
                    price: 56,
                    author: 23,
                    id: 32
                )
            ),
            viewVodel: CartViewModel(
                nftService: NFTService(),
                cartService: CartService()
            )
        )
    }
}
