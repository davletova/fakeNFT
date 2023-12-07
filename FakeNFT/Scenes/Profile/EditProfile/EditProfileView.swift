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
    @ObservedObject var viewModel: ProfileViewModel
    
    @Environment(\.dismiss) var dismiss
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    LazyImage(url: viewModel.profile!.getAvatarURL()) { state in
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
                    TextField(
                        "",
                        text: $viewModel.name,
                        prompt: Text("Не должно быть пустым")
                            .foregroundColor(Color.appRed.opacity(0.8))
                            .font(.system(size: 14, weight: .regular))
                            )
                        .font(.system(size: 17, weight: .regular))
                        .padding(16)
                        .frame(minHeight: 50)
                        .background(Color.appLightGray)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(RoundedRectangle(cornerRadius: 12)
                            .stroke(viewModel.nameIsValid ? Color.clear : Color.appRed))
                }
                VStack(alignment: .leading) {
                    Text("Описание")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(Color.appBlack)
                    TextField("Введите описание", text: $viewModel.desc, axis: .vertical)
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
                    viewModel.updateProfile()
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(Color.appBlack)
                }
                .disabled(!viewModel.nameIsValid)
            }
        }
    }
}

//struct EditProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditProfileView(
//            viewModel: EditProfileViewModel(
//                profile: ProfileDisplayModel(
//                    profile: Profile(
//                        name: "Alex Swensen",
//                        avatar: "https://code.s3.yandex.net/landings-v2-ios-developer/space.PNG",
//                        description: "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям.",
//                        website: "https://practicum.yandex.ru/ios-developer",
//                        id: 1
//                    ),
//                    nfts: [],
//                    likes:[]
//                ),
//                service: ProfileService()
//            )
//        )
//    }
//}
