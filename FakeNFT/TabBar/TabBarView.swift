//
//  TabBarView.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 12.11.2023.
//

import Foundation
import SwiftUI

struct TabBarView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            CollectionView(
                coverURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Обложки_коллекций/Beige.png".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!)!,
                name: "Peach",
                description: "Персиковый — как облака над закатным солнцем в океане. В этой коллекции совмещены трогательная нежность и живая игривость сказочных зефирных зверей.",
                author: "John Doe"
            )
                .tabItem {
                    selectedTab == 0 ? Label("Профиль", image: "profileActive") : Label("Профиль", image: "profileNoActive")
                }
                .tag(0)
            ListCollectionsView()
                .tabItem {
                    selectedTab == 1 ? Label("Каталог", image: "catalogActive") : Label("Каталог", image: "catalogNoActive")
                }
                .tag(1)
            Text("Корзина")
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

