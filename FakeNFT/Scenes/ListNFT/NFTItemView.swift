//
//  CollectionItemView.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 09.11.2023.
//

import Foundation
import SwiftUI
import Kingfisher

struct NFTItemView: View {
    @State private var nft: NFTDisplayModel
    
    init(nft: NFTDisplayModel) {
        _nft = State(initialValue: nft)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topTrailing) {
                KFImage(nft.getImageURLs()[0])
                    .resizable()
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 12))
//                    .frame(width: .infinity)
                Image(nft.isLike ? "like" : "noLike")
                    .frame(width: 40, height: 40)
            }
            Image("stars\(nft.nft.rating)")
                .frame(width: 68, height: 12)
                .padding(.bottom, 4)
            HStack {
                VStack(alignment: .leading) {
                    Text(nft.nft.name)
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(Color.appBlack)
                        .padding(.bottom, 4)
                    Text("\(nft.nft.price.description) ETH")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundStyle(Color.appBlack)
                }
                Spacer()
                Image(nft.isOnOrder ? "basket" : "basketCross")
                    .frame(width: 30, height: 30)
            }
            //.frame(maxWidth: .infinity)
        }
//        .frame(width: width, height: width + 64)
    }
}

struct NFTItemView_Previews: PreviewProvider {
    static var previews: some View {
        NFTItemView(
            nft: NFTDisplayModel(
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
                    author: "23",
                    id: "32"
                ),
            isLike: true,
            isOnOrder: false
            )
        )
    }
}
