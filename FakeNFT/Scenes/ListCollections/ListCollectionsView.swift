//
//  View.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 09.11.2023.
//

import Foundation
import SwiftUI

struct ListCollectionsView: View {
    @StateObject var viewModel = ListCollectionsViewModel(service: CollectionService())
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.collections) { c in
                        //TODO: обработать кейс когда getURL == nil
                        CollectionItemView(name: c.collection.name, imageURL: c.getCoverURL()!)
                            .onAppear(){
                                viewModel.fetchNextPageIfPossible()
                            }
                    }
                }
            }
            .toolbar {
                Button {
                    print("SORT")
                } label: {
                    Image("sort")
                }
            }
        }
    }
}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        ListCollectionsView()
    }
}
