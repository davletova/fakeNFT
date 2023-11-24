//
//  CartView.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 24.11.2023.
//

import Foundation
import SwiftUI

struct CartView: View {
    @ObservedObject var viewModel: CartViewModel
    @State private var isConfirming = false
    
    var body: some View {
        NavigationStack {
            VStack {
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
                            ForEach(viewModel.cartNFTDisplayModels) { (nft: CartNFTDisplayModel) in
                                CartItemView(nft: nft)
                                    .padding(.vertical, 16)
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
                ZStack {
                    Color.appLightGray
                        .frame(height: 76)
                    HStack {
                        VStack {
                            let sum = viewModel.cartNFTDisplayModels
                                .map {$0.nft.price}
                                .reduce(0,+)
                            Text("\(viewModel.cartNFTDisplayModels.count) NFT")
                                .font(.system(size: 15, weight: .regular))
                                .foregroundStyle(Color.appBlack)
                            Text("\(String(format: "%.2f", sum)) ETH")
                                .font(.system(size: 17, weight: .bold))
                                .foregroundStyle(Color.appGreen)
                        }
                        .padding(.trailing, 24)
                        ZStack {
                            Color.appBlack
                                .frame(height: 44)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                            Text("К оплате")
                                .font(.system(size: 17, weight: .bold))
                                .foregroundStyle(Color.appWhite)
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .clipShape(
                    .rect(
                        topLeadingRadius: 12,
                        bottomLeadingRadius: 0,
                        bottomTrailingRadius: 0,
                        topTrailingRadius: 12
                    )
                )
            }
            .padding(.top, 36)
            
            .toolbar {
                Button {
                    self.isConfirming = true
                } label: {
                    Image("sort")
                }
            }
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(viewModel: CartViewModel(nftService: NFTService(), orderService: OrderService()))
    }
}
