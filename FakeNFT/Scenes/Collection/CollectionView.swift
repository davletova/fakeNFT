//
//  CollectionView.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 14.11.2023.
//

import Foundation
import SwiftUI
import Kingfisher

struct CollectionView: View {
    @State private var coverURL: URL
    @State private var name: String
    @State private var description: String
    @State private var author: String
    
    init(coverURL: URL, name: String, description: String, author: String) {
        _coverURL = State(initialValue: coverURL)
        _name = State(initialValue: name)
        _description = State(initialValue: description)
        _author = State(initialValue: author)
    }
    
    var body: some View {
        VStack() {
            ZStack(alignment: .top) {
                KFImage(coverURL)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .frame(maxWidth: .infinity)
            }
            VStack(alignment: .leading) {
                Text(name)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(Color.appBlack)
                    .padding(.top, 16)
                    .padding(.bottom, 8)
                HStack(alignment: .bottom, spacing: 0) {
                    Text("Автор коллекции: ")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundStyle(Color.appBlack)
                    Text(author)
                        .font(.system(size: 15, weight: .regular))
                        .foregroundStyle(Color.appBlue)
                }
                .padding(.bottom, 2)
                Text(description)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundStyle(Color.appBlack)
                    .padding(.top, 0)
            }
            .padding(.horizontal, 16)
            Spacer()
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView(
            coverURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Обложки_коллекций/Beige.png".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!)!,
            name: "Peach",
        description: "Персиковый — как облака над закатным солнцем в океане. В этой коллекции совмещены трогательная нежность и живая игривость сказочных зефирных зверей.",
        author: "John Doe"
        )
    }
}
