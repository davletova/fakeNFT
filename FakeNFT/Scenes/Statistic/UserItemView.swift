//
//  UserItemView.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 13.11.2023.
//

import Foundation
import SwiftUI
import Kingfisher

struct UserItemView: View {
    @State private var number: Int
    @State private var name: String
    @State private var avatarURL: URL
    @State private var position: String
    
    init(number: Int, name: String, avatarURL: URL, position: String) {
        _number = State(initialValue: number)
        _name = State(initialValue: name)
        _avatarURL = State(initialValue: avatarURL)
        _position = State(initialValue: position)
    }
    
    var body: some View {
        HStack(spacing: 8) {
            Text(number.description)
                .frame(width: 27, height: 20)
                .font(.system(size: 15, weight: .regular))
                .foregroundStyle(Color.appBlack)
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
            HStack {
                KFImage(avatarURL)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .shadow(radius: 4)
                    .padding(.leading, 16)
                Text(name)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(Color.appBlack)
                Spacer()
                Text(position.description)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(Color.appBlack)
                    .padding(.trailing, 16)
                Spacer()
            }
            .frame(height: 80)
            .background(Color.appLightGray)
            .cornerRadius(16)
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 80, maxHeight: 80, alignment: .leading)
        .frame(height: 80)
    }
}

struct UserItemView_Previews: PreviewProvider {
    static var previews: some View {
        UserItemView(
            number: 2,
            name: "Алексей Смирнов",
            avatarURL: URL(string: "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/179.jpg".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!)!,
            position: 23.description
        )
    }
}
