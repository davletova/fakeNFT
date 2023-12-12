//
//  TabBarViewModel.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 11.12.2023.
//

import Foundation
import Combine

enum SelectedTab: String, Hashable {
    case profile, collection, cart, statistic
}

class TabBarViewModel: ObservableObject {
    @Published var selectedTab = SelectedTab.collection
}

