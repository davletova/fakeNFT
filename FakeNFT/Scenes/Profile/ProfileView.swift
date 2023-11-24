//
//  ProfileView.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 21.11.2023.
//

import Foundation
import SwiftUI
import NukeUI

enum ProfileViewRoute {
    case favorites, mynft, website
}

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @State private var showingPopover = false
    
    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.state {
                case .loaded:
                    VStack {
                        VStack(alignment: .leading) {
                            HStack {
                                LazyImage(url: viewModel.profile?.getAvatarURL()) { state in
                                    if let image = state.image {
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 70, height: 70)
                                            .clipShape(Circle())
                                            .padding(.trailing, 16)
                                    } else if state.error != nil {
                                        Color.red // Indicates an error
                                    } else {
                                        Color.appLightGray
                                            .frame(width: 70, height: 70)
                                            .clipShape(Circle())
                                            .padding(.trailing, 16)
                                    }
                                }
                                Text(viewModel.profile?.profile.name ?? "")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(.appBlack)
                                Spacer()
                            }
                            .padding(.bottom, 20)
//                            .padding(.horizontal, 16)
                            Text(viewModel.profile?.profile.description ?? "")
                                .font(.system(size: 13, weight: .regular))
                                .foregroundColor(.appBlack)
                                .padding(.bottom, 60)
//                                .padding(.horizontal, 16)
                            VStack(spacing: 32) {
                                NavigationLink(value: ProfileViewRoute.mynft) {
                                    HStack {
                                        Text("Мои NFT (\(viewModel.profile?.profile.nfts.count ?? 0))")
                                            .font(.system(size: 17, weight: .bold))
                                            .foregroundColor(.appBlack)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                    }
                                }
                                NavigationLink(value: ProfileViewRoute.favorites) {
                                    HStack {
                                        Text("Избранные NFT (\(viewModel.profile?.profile.nfts.count ?? 0))")
                                            .font(.system(size: 17, weight: .bold))
                                            .foregroundColor(.appBlack)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                    }
                                }
                                NavigationLink(value: ProfileViewRoute.website) {
                                    HStack {
                                        Text("О разработчике")
                                            .font(.system(size: 17, weight: .bold))
                                            .foregroundColor(.appBlack)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                        Spacer()
                            .navigationDestination(for: ProfileViewRoute.self) { route in
                                switch route {
                                case .favorites:
                                    ListNFTView(
                                        viewModel: ListNFTViewModel(
                                            nfts: viewModel.profile?.profile.likes ?? [],
                                            nftService: NFTService(),
                                            profileService: ProfileService(),
                                            orderService: OrderService()
                                        )
                                    )
                                    .padding(.horizontal, 16)
                                    .padding(.top, 36)
                                    .navigationTitle("Избранные NFT")
                                case .mynft:
                                    MyNFTListView(
                                        viewModel: MyNFTListViewModel(
                                            nftIDs: viewModel.profile?.profile.nfts ?? [],
                                            nftService: NFTService(),
                                            profileService: ProfileService(),
                                            userService: UserService()
                                        )
                                    )
                                    .padding(.horizontal, 16)
                                    .padding(.top, 36)
                                    .navigationTitle("Мои NFT")
                                case .website:
                                    WebView(url: viewModel.profile!.getWebsiteURL()!)
                                }
                            }
                    }
                case .loading:
                    ProgressView()
                        .frame(width: 60, height: 60)
                        .padding(.top, 100)
                case .failed(_):
                    Text("ERROR")
                        .font(.system(size: 24, weight: .semibold))
                        .frame(width: 200, height: 200)
                }
            }
            
            .padding(.top, 20)
            .toolbar {
                Button {
                    print("EDIT")
                    showingPopover = true
                } label: {
                    Image(systemName: "square.and.pencil")
                        .foregroundColor(.appBlack)
                        .font(.system(size: 20, weight: .semibold))
                }
                .popover(isPresented: $showingPopover) {
                    EditProfileView(
                        viewModel: EditProfileViewModel(
                            profile: viewModel.profile!.profile
                        )
                    )
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: ProfileViewModel(service: ProfileService()))
    }
}
