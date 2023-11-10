//
//  View.swift
//  FakeNFT
//
//  Created by Алия Давлетова on 09.11.2023.
//

import Foundation
import SwiftUI

struct CollectionsView: View {
    @StateObject var collectionVM = CollectionsViewModel(service: CollectionService(networkClient: DefaultNetworkClient()))
    
    var body: some View {
        NavigationView{
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
        }
    }
}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionsView()
    }
}
