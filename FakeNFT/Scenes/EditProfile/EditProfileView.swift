//
//  EditProfileView.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 23.11.2023.
//

import Foundation
import SwiftUI
import NukeUI

struct EditProfileView: View {
    @ObservedObject var viewModel: EditProfileViewModel
   
    @Environment(\.dismiss) var dismiss
    
    init(viewModel: EditProfileViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    LazyImage(url: viewModel.profile.getAvatarURL()) { state in
                        if let image = state.image {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 70, height: 70)
                                .clipShape(Circle())
                                .padding(.trailing, 16)
                                .brightness(-0.6)
                        } else if state.error != nil {
                            Color.red // Indicates an error
                        } else {
                            Color.appLightGray
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                                .padding(.trailing, 16)
                        }
                    }
                    Text("Сменить фото")
                        .padding(.trailing, 16)
                        .font(.system(size: 10, weight: .medium))
                        .foregroundStyle(Color.appWhite)
                        .frame(maxWidth: 70)
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                    
                }
                VStack(alignment: .leading) {
                    Text("Имя")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(Color.appBlack)
                    TextField("Введите свое имя", text: $viewModel.name)
                        .font(.system(size: 17, weight: .regular))
                        .padding(16)
                        .frame(minHeight: 50)
                        .background(Color.appLightGray)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                VStack(alignment: .leading) {
                    Text("Описание")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(Color.appBlack)
                    TextField("Введите описание", text: $viewModel.description, axis: .vertical)
                        .font(.system(size: 17, weight: .regular))
                        .padding(16)
                        .frame(minHeight: 50)
                        .background(Color.appLightGray)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                VStack(alignment: .leading) {
                    Text("Сайт")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(Color.appBlack)
                    TextField("Введите сайт", text: $viewModel.website, axis: .vertical)
                        .font(.system(size: 17, weight: .regular))
                        .padding(16)
                        .frame(minHeight: 50)
                        .background(Color.appLightGray)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding(.horizontal)
            .toolbar {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(Color.appBlack)
                }
            }
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(
            viewModel: EditProfileViewModel(
                profile: Profile(
                    name: "Alex Swensen",
                    avatar: "https://code.s3.yandex.net/landings-v2-ios-developer/space.PNG",
                    description: "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям.",
                    website: "https://practicum.yandex.ru/ios-developer",
                    nfts: ["68","69","71","72","73","74","75","76","77","78","79","80","81"],
                    likes: ["5","13","19","26","27","33","35","39","41","47","56","66"],
                    id: "1"
                )
            )
        )
    }
}
