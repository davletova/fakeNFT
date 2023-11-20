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
    var nfts: [NFTDisplayModel]
    
    init(nfts: [NFTDisplayModel]) {
        self.nfts = nfts
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: minNFTWidrh))], spacing: 28) {
                ForEach(nfts) { nft in
                    NFTItemView(nft: nft)
                }
            }
        }
        
    }
}

struct ListNFTView_Previews: PreviewProvider {
    static var previews: some View {
        ListNFTView(nfts: [
            NFTDisplayModel(
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
            ),
            NFTDisplayModel(
                nft: NFT(
                    createdAt: "2023-04-20T02:22:27Z",
                    name: "April",
                    images: [
                        "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/1.png",
                        "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/2.png",
                        "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/3.png"
                    ],
                    rating: 5,
                    description: "A 3D model of a mythical creature.",
                    price: 4.5,
                    author: "6",
                    id: "1"),
                isLike: false,
                isOnOrder: true
            ),
            NFTDisplayModel(
                nft: NFT(
                    createdAt: "2023-04-20T02:22:27Z",
                    name: "Aurora",
                    images: [
                        "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Aurora/1.png",
                        "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Aurora/2.png",
                        "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Aurora/3.png"
                    ],
                    rating: 4,
                    description: "An abstract painting of a fiery sunset.",
                    price: 1.69,
                    author: "6",
                    id: "2"
                ),
                isLike: false,
                isOnOrder: false
            ),
            NFTDisplayModel(
                nft: NFT(
                    createdAt: "2023-04-20T02:22:27Z",
                    name: "Bimbo",
                    images: [
                        "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Bimbo/1.png",
                        "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Bimbo/2.png",
                        "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Bimbo/3.png"
                    ],
                    rating: 4,
                    description: "A surreal landscape featuring floating islands and waterfalls.",
                    price: 6.02,
                    author: "6",
                    id: "3"
                ),
                isLike: false,
                isOnOrder: false
            ),
            NFTDisplayModel(
                nft: NFT(
                    createdAt: "2023-04-20T02:22:27Z",
                    name: "Buster",
                    images: [
                        "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Buster/1.png",
                              "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Buster/2.png",
                              "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Buster/3.png"
                    ],
                    rating: 3,
                    description: "An artistic representation of a meteor shower in outer space.",
                    price: 4.7,
                    author: "6",
                    id: "6"
                ),
                isLike: false,
                isOnOrder: true
            ),
        ])
    }
}
