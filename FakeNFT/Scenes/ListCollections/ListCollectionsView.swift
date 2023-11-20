//
//  View.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 09.11.2023.
//

import Foundation
import SwiftUI

struct ListCollectionsView: View {
    @ObservedObject var viewModel: ListCollectionsViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.collections) { (collectionDisplayModel: CollectionDisplayModel) in
                        //TODO: обработать кейс когда getURL == nil
                        NavigationLink {
                            CollectionView(collection: collectionDisplayModel.collection)
                        } label: {
                            CollectionItemView(name: collectionDisplayModel.collection.name, imageURL: collectionDisplayModel.getCoverURL()!)
                                .onAppear(){
                                    viewModel.fetchNextPageIfPossible()
                                }
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
            .onAppear {
                viewModel.fetchNextPageIfPossible()
            }
        }
    }
}
