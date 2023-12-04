//
//  TabBarView.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 12.11.2023.
//

import Combine
import Foundation
import SwiftUI

struct TabBarView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ProfileView(viewModel: ProfileViewModel(service: ProfileService()))
                .tabItem {
                    selectedTab == 0 ? Label("Профиль", image: "profileActive") : Label("Профиль", image: "profileNoActive")
                }
                .tag(0)
            CollectionListView(viewModel: CollectionListViewModel(service: CollectionService()))
                .tabItem {
                    selectedTab == 1 ? Label("Каталог", image: "catalogActive") : Label("Каталог", image: "catalogNoActive")
                }
                .tag(1)
            CartView(viewModel: CartViewModel(nftService: NFTService(), cartService: CartService()))
                .tabItem {
                    selectedTab == 2 ? Label("Корзина", image: "basketActive") : Label("Корзина", image: "basketNoActive")
                }
                .tag(2)
            ListUsersContainer(viewModel: StatisticViewModel(service: UserService()))
                .tabItem {
                    selectedTab == 3 ? Label("Статистика", image: "statisticActive") : Label("Статистика", image: "statisticNoActive")
                }
                .tag(3)
        }
    }
}

