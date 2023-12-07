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
    private var minWidth: CGFloat = 100
    
    @ObservedObject var viewModel: CurrencySelectionViewModel
    
    init(viewModel: CurrencySelectionViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: minWidth))], spacing: 28) {
            ForEach(viewModel.currencies) { currency in
                CurrencyItemView(currency: currency)
            }
        }
        
    }
}

struct CurrencyItemView: View {
    var currency: CurrencyDisplayModel
    
    var body: some View {
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
        .foregroundColor(Color.appLightGray)
    }
}

struct CurrencySelectionView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencySelectionView(viewModel: CurrencySelectionViewModel(service: CurrencyService()))
    }
}
