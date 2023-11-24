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
                switch viewModel.state {
                case .loaded:
                    LazyVStack {
                        ForEach(viewModel.collections) { (collectionDisplayModel: CollectionDisplayModel) in
                            //TODO: обработать кейс когда getURL == nil
                            NavigationLink(value: collectionDisplayModel) {
                                CollectionItemView(name: collectionDisplayModel.collection.name, imageURL: collectionDisplayModel.getCoverURL()!)
                                    .onAppear(){
                                        viewModel.fetchNextPageIfPossible()
                                }
                            }
                        }
                        .navigationDestination(for: CollectionDisplayModel.self) { collectionDisplayModel in
                            CollectionView(collection: collectionDisplayModel.collection)
                        }
                    }
                case .loading:
                    ProgressView()
                        .frame(width: 60, height: 60)
                        .padding(.top, 100)
                case .failed(_):
                    Text("ERROR")
                        .font(.system(size: 24, weight: .bold))
                        .frame(width: 200, height: 200)
                }
            }
            .toolbar {
                Button {
                    print("SORT")
                } label: {
                    Image("sort")
                }
            }
//            .onAppear {
//                print("onAppear")
//                viewModel.fetchNextPageIfPossible()
//            }
        }
    }
}
