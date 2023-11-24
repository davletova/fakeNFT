//
//  MyNFTListView.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 22.11.2023.
//

import Foundation
import SwiftUI
import Combine

struct MyNFTListView: View {
    @ObservedObject var viewModel: MyNFTListViewModel
    
    init(viewModel: MyNFTListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            switch viewModel.state {
            case .loading:
                ProgressView()
                    .frame(width: 60, height: 60)
                    .padding(.top, 100)
            case .failed(_):
                Text("ERROR")
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 200, height: 200)
            case .loaded:
                LazyVStack {
                    ForEach(viewModel.nftDisplayModels) { (nft: MyNFTDisplayModel) in
                        MyNFTItemView(nft: nft)
                    }
                }
            }
        }
    }
}
