//
//  DeleteNFTView.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 25.11.2023.
//

import Foundation
import SwiftUI
import NukeUI

struct DeleteNFTView: View {
    var viewModel: CartViewModel
    var nft: CartNFTDisplayModel
    
    var body: some View {
        ZStack{
            VStack {
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
                            .clipShape(Circle())
                            .padding(.trailing, 16)
                    }
                }
                .padding(.bottom, 12)
                Text("Вы уверены, что хотите\nудалить объект из корзины?")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundStyle(Color.appBlack)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)
                HStack {
                    Button("Удалить") {
                        viewModel.deleteItem(item: nft)
                        viewModel.deleteNFT = nil
                    }
                    .frame(width: 127, height: 44)
                    .background(Color.appBlack)
                    .tint(Color.appBlack)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .foregroundStyle(Color.appRed)
                    Button("Вернуться") {
                        viewModel.deleteNFT = nil
                    }
                    .frame(width: 127, height: 44)
                    .background(Color.appBlack)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .tint(Color.appBlack)
                    .foregroundStyle(Color.appWhite)
                }
            }
        }
    }
}

struct DeleteNFTView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteNFTView(
            viewModel: CartViewModel(
                nftService: NFTService(),
                cartService: CartService()),
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
            )
        )
    }
}
