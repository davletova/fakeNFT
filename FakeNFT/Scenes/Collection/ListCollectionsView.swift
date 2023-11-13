//
//  View.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 09.11.2023.
//

import Foundation
import SwiftUI

struct ListCollectionsView: View {
    @StateObject var collectionVM = ListCollectionsViewModel(service: CollectionService(networkClient: DefaultNetworkClient()))
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(collectionVM.collections, id: \.self.id) { c in
                        CollectionItemView(name: c.name, imageURL: c.cover)
                            .onAppear(){
                                collectionVM.loadMoreContent(currentItem: c)
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
