//
//  CollectionItemView.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 09.11.2023.
//

import Foundation
import SwiftUI
import Kingfisher

protocol NftItemViewModelProtocol: ObservableObject {
    var nftDisplayModel: NFTDisplayModel { get }
    
    func likeNft(_ id: Int)
    func unlikeNft(_ id: Int)
    func addToCart(_ id: Int)
    func deleteFromCart(_ id: Int)
}

struct NFTItemView<ViewModel>: View where ViewModel: NftItemViewModelProtocol {    
    @ObservedObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topTrailing) {
                KFImage(viewModel.nftDisplayModel.getImageURLs()[0])
                    .resizable()
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 12))
//                    .frame(width: .infinity)
                Button {
                    viewModel.nftDisplayModel.isLike ? viewModel.unlikeNft(viewModel.nftDisplayModel.id) : viewModel.likeNft(viewModel.nftDisplayModel.id)
                } label: {
                    Image(viewModel.nftDisplayModel.isLike ? "like" : "noLike")
                        .frame(width: 40, height: 40)
                }
            }
            Image("stars\(viewModel.nftDisplayModel.nft.rating)")
                .frame(width: 68, height: 12)
                .padding(.bottom, 4)
            HStack {
                VStack(alignment: .leading) {
                    Text(viewModel.nftDisplayModel.nft.name)
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(Color.appBlack)
                        .padding(.bottom, 4)
                    Text("\(viewModel.nftDisplayModel.nft.price.description) ETH")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundStyle(Color.appBlack)
                }
                Spacer()
                Button {
                    viewModel.nftDisplayModel.isOnOrder ? viewModel.deleteFromCart(viewModel.nftDisplayModel.id) : viewModel.addToCart(viewModel.nftDisplayModel.id)
                } label: {
                    Image(viewModel.nftDisplayModel.isOnOrder ? "basketCross" : "basket")
                        .frame(width: 30, height: 30)
                }
            }
        }
    }
}

struct NFTItemView_Previews: PreviewProvider {
    static var previews: some View {
        NFTItemView(
            viewModel: MockNftItemViewModel(
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
                    author: 23,
                    id: 32
                ),
            isLike: true,
            isOnOrder: false
            )
        )
        )
    }
}

class MockNftItemViewModel: NftItemViewModelProtocol {
    var nftDisplayModel: NFTDisplayModel
    
    init(nft: NFTDisplayModel) {
        self.nftDisplayModel = nft
    }
    
    func likeNft(_ id: Int) {
        print("likeNft")
    }
    
    func unlikeNft(_ id: Int) {
        print("unlikeNft")
    }
    
    func addToCart(_ id: Int) {
        print("addToCart")
    }
    
    func deleteFromCart(_ id: Int) {
        print("deleteFromCart")
    }
}
