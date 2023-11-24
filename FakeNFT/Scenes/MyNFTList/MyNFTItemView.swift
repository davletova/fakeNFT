//
//  MyNFTItemView.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 22.11.2023.
//

import Foundation
import SwiftUI
import NukeUI

struct MyNFTItemView: View {
    @State private var nft: MyNFTDisplayModel
    
    init(nft: MyNFTDisplayModel) {
        _nft = State(initialValue: nft)
    }
    
    var body: some View {
        HStack {
            ZStack(alignment: .topTrailing) {
                LazyImage(url: nft.getImageURLs()[0]) { state in
                    if let image = state.image {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 108, height: 108)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    } else if state.error != nil {
                        Color.red // Indicates an error
                    } else {
                        Color.appLightGray
                            .frame(width: 108, height: 108)
                    }
                }
                Image(nft.isLike ? "like" : "noLike")
                    .frame(width: 40, height: 40)
            }
            .padding(.trailing, 20)
            VStack(alignment: .leading) {
                Text(nft.nft.name)
                    .font(.system(size: 17, weight: .bold))
                //TODO: foregroundColor deprecated
                    .foregroundColor(Color.appBlack)
                Image("stars\(nft.nft.rating)")
                    .frame(width: 68, height: 12)
                Text("от \(nft.author)")
                    .font(.system(size: 15, weight: .regular))
            }
            Spacer()
            VStack(alignment: .leading) {
                Text("Цена")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(Color.appBlack)
                Text("\(nft.nft.price.description) ETH")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(Color.appBlack)
            }
        }
    }
}

struct MyNFTItemView_Previews: PreviewProvider {
    static var previews: some View {
        MyNFTItemView(
            nft: MyNFTDisplayModel(
                nft: NFT(
                    createdAt: "",
                    name: "Archie",
                    images: [
                        "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/1.png",
                        "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/2.png",
                        "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/3.png"
                    ],
                    rating: 3,
                    description: "Персиковый — как облака над закатным солнцем в океане. В этой коллекции совмещены трогательная нежность и живая игривость сказочных зефирных зверей.",
                    price: 56,
                    author: "23",
                    id: "32"
                ),
                isLike: true,
                author: "Alex Smith"
            )
        )
    }
}
