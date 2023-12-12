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
    @ObservedObject var viewModel = TabBarViewModel()
    
    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            ProfileView(viewModel: ProfileViewModel(service: ProfileService()))
                .tabItem {
                    viewModel.selectedTab == .profile ? Label("Профиль", image: "profileActive") : Label("Профиль", image: "profileNoActive")
                }
                .tag(SelectedTab.profile)
            CollectionListView(viewModel: CollectionListViewModel(service: CollectionService()))
                .tabItem {
                    viewModel.selectedTab == .collection ? Label("Каталог", image: "catalogActive") : Label("Каталог", image: "catalogNoActive")
                }
                .tag(SelectedTab.collection)
            CartView(viewModel: CartViewModel(nftService: NFTService(), cartService: CartService()))
                .tabItem {
                    viewModel.selectedTab == .cart ? Label("Корзина", image: "basketActive") : Label("Корзина", image: "basketNoActive")
                }
                .tag(SelectedTab.cart)
            ListUsersContainer(viewModel: StatisticViewModel(service: UserService()))
                .tabItem {
                    viewModel.selectedTab == .statistic ? Label("Статистика", image: "statisticActive") : Label("Статистика", image: "statisticNoActive")
                }
                .tag(SelectedTab.statistic)
        }
    }
}

