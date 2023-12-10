//
//  PaymentSelectionView.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 05.12.2023.
//

import Foundation
import SwiftUI
import NukeUI

struct CurrencySelectionView: View {
    private var minWidth: CGFloat = 150
    
    @ObservedObject var viewModel: CurrencySelectionViewModel
    
    init(viewModel: CurrencySelectionViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: minWidth))], spacing: 28) {
                ForEach(viewModel.currencies) { currency in
                    CurrencyItemView(currency: currency, viewModel: viewModel)
                        .onTapGesture {
                            viewModel.selectedCurrency = currency.currency
                        }
                }
            }
            .padding(.top, 20)
            .padding(.horizontal, 16)
                
            Spacer()

            ZStack {
                Color.appLightGray
                    .frame(height: 186)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .ignoresSafeArea(.all, edges: .bottom)
                VStack(spacing: 16) {
                    VStack(alignment: .leading) {
                        Text("Совершая покупку, вы соглашаетесь с условиями")
                            .font(.system(size: 13, weight: .regular))
                            .foregroundStyle(Color.appBlack)
                        NavigationLink {
                            WebView(url: cartPrivatePolicy)
                                .toolbar(.hidden, for: .tabBar)
                        } label: {
                            Text("Пользовательского соглашения")
                                .font(.system(size: 13, weight: .regular))
                                .foregroundStyle(Color.appBlue)
                        }
                    }
                    Button {
                        
                    } label: {
                        ZStack {
                            Color.appBlack
                                .frame(height: 60)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .opacity(viewModel.selectedCurrency != nil ? 1 : 0.3)
                            Text("Оплатить")
                                .font(.system(size: 17, weight: .bold))
                                .foregroundStyle(Color.appWhite)
                        }
                    }
                    .disabled(viewModel.selectedCurrency == nil)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 34)
            }
            .frame(height: 186)
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

struct CurrencyItemView: View {
    var currency: CurrencyDisplayModel
    
    @ObservedObject var viewModel: CurrencySelectionViewModel
    
    var body: some View {
        ZStack {
            Color.appLightGray
                .frame(height: 46)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(RoundedRectangle(cornerRadius: 12)
                    .stroke(viewModel.selectedCurrency?.id != currency.id ? Color.clear : Color.appBlack))
            HStack {
                LazyImage(url: currency.getImageURL()) { state in
                    if let image = state.image {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 36, height: 36)
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                    } else if state.error != nil {
                        Color.red // Indicates an error
                    } else {
                        Color.appLightGray
                            .frame(width: 35, height: 36)
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                    }
                }
                VStack(alignment: .leading) {
                    Text(currency.currency.title)
                        .font(.system(size: 13, weight: .regular))
                        .foregroundStyle(Color.appBlack)
                    Text(currency.currency.name)
                        .font(.system(size: 13, weight: .regular))
                        .foregroundStyle(Color.appGreen)
                }
            }
            .frame(height: 46)
        }
    }
}

struct CurrencySelectionView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencySelectionView(viewModel: CurrencySelectionViewModel(service: CurrencyService()))
    }
}
