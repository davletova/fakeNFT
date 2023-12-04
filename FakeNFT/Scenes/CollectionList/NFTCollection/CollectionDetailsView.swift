//
//  CollectionView.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 14.11.2023.
//

import Foundation
import SwiftUI
import Kingfisher

struct CollectionDetailsView: View {
    @ObservedObject var viewModel: CollectionDetailsViewModel
    
    init(collection: Collection) {
        self.viewModel = CollectionDetailsViewModel(collection: collection, userService: UserService())
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .top) {
                KFImage(viewModel.collection.getCoverURL())
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .frame(maxWidth: .infinity)
            }
            ScrollView {
                VStack(alignment: .leading) {
                    Text(viewModel.collection.collection.name)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(Color.appBlack)
                        .padding(.top, 16)
                        .padding(.bottom, 8)
                    HStack(alignment: .bottom, spacing: 0) {
                        Text("Автор коллекции: ")
                            .font(.system(size: 13, weight: .regular))
                            .foregroundStyle(Color.appBlack)
                        Text(viewModel.author)
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(Color.appBlue)
                        Spacer()
                    }
                    .padding(.bottom, 2)
                    Text(viewModel.collection.collection.description)
                        .font(.system(size: 13, weight: .regular))
                        .foregroundStyle(Color.appBlack)
                        .padding(.top, 0)
                }
                .padding(.bottom, 24)
                
                ListNFTCollectionView(
                    viewModel: ListNFTCollectionViewModel(
                        nftIds: viewModel.collection.collection.nfts,
                        nftService: NFTService(),
                        profileService: ProfileService(),
                        cartService: CartService()
                    )
                )
                
            }
            .padding(.horizontal, 16)
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionDetailsView(
            collection: Collection(
                name: "Peach",
                cover: "https://code.s3.yandex.net/Mobile/iOS/NFT/Обложки_коллекций/Beige.png",
                nfts: [1, 2, 3, 4],
                description: "Персиковый — как облака над закатным солнцем в океане. В этой коллекции совмещены трогательная нежность и живая игривость сказочных зефирных зверей.",
                author: 5,
                id: 1
            )
        )
    }
}
