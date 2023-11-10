//
//  CollectionItemView.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 09.11.2023.
//

import Foundation
import SwiftUI
import Kingfisher

struct KingfisherImageView: View {
    var imageUrl: URL?
    
    var body: some View {
        KFImage(imageUrl)
            .resizable()
            .scaledToFill()
            .frame(minWidth: 0, maxWidth: .infinity)
            .cornerRadius(16)
            .clipped()
    }
}

struct CollectionItemView: View {
    @State private var title: String
    @State private var url: URL
    
    
    init(name: String, imageURL: URL) {
        _title = State(initialValue: name)
        _url = State(initialValue: imageURL)
    }
    
    var body: some View {
        VStack(spacing: 4) {
            //            AsyncImage(url: url) { phase in
            //                switch phase {
            //                case .empty:
            //                    ProgressView()
            //                case .success(let image):
            //                    image
            //                        .resizable()
            //                        .scaledToFill()
            //                        .frame(minWidth: 0, maxWidth: .infinity)
            //                        .cornerRadius(16) // Здесь указывается радиус скругления углов
            //                        .padding(.horizontal, 16)
            //                case .failure:
            //                    Text("Failed to load image")
            //                @unknown default:
            //                    EmptyView()
            //                }
            KingfisherImageView(imageUrl: url)
                .padding(.horizontal, 16)
        }
        HStack {
            Text(title)
                .font(.system(size: 17))
                .fontWeight(.bold)
                .foregroundColor(Color.appBlack)
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
            Spacer()
        }
    }
}

struct CollectionItemView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionItemView(name: "Peach (11)", imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Обложки_коллекций/Beige.png".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!)!)
    }
}
