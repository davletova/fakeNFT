//
//  CollectionItemView.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 09.11.2023.
//

import Foundation
import SwiftUI
import Kingfisher

struct CollectionItemView: View {
    @State private var title: String
    @State private var url: URL
    
    init(name: String, imageURL: URL) {
        _title = State(initialValue: name)
        _url = State(initialValue: imageURL)
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 4) {
                KFImage(url)
                    .resizable()
                    .scaledToFill()
                    .frame(height: (UIScreen.main.bounds.width - 32) * 0.5)
                //TODO: cornerRadius deprecated
                    .cornerRadius(16)
                    .clipped()
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
}

struct CollectionItemView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionItemView(name: "Peach (11)", imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Обложки_коллекций/Beige.png".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!)!)
    }
}
