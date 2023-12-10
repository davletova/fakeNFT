import Foundation
import SwiftUI
import NukeUI

struct SuccessfulPurchase: View {
    var nft: CartNFTDisplayModel
    
    var body: some View {
        VStack {
            Spacer()
            LazyImage(url: nft.getImageURLs()[2]) { state in
                if let image = state.image {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 278, height: 278)
                        .padding(.trailing, 20)
                } else if state.error != nil {
                    Color.red // Indicates an error
                } else {
                    Color.appLightGray
                        .frame(width: 70, height: 70)
                        .padding(.trailing, 16)
                }
            }
            Text("Успех! Оплата прошла, поздравляем с покупкой!")
                .lineLimit(2)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(Color.appBlack)
                .multilineTextAlignment(.center)
    
            Spacer()
            NavigationStack {
                NavigationLink(
                    destination: CollectionListView(viewModel: CollectionListViewModel(service: CollectionService())))
                {
                    ZStack {
                        Color.appBlack
                            .frame(height: 60)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        Text("Вернуться в каталог")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundStyle(Color.appWhite)
                    }
                }
                .padding(.bottom, 16)
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
    }
}


struct SuccessfulPurchase_Previews: PreviewProvider {
    static var previews: some View {
        SuccessfulPurchase(nft: CartNFTDisplayModel(nft: NFT(
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
        )))
    }
}
