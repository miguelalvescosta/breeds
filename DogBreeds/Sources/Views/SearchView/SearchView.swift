//
//  SearchView.swift
//  DogBreeds
//
//  Created by Miguel Costa on 11.01.23.
//

import Foundation
import SwiftUI
struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel
   
    @State private var searchText = ""
    init() {
        self.viewModel = SearchViewModel()
        viewModel.fetchSearchList()
    }
    var body: some View {
        NavigationStack {
            VStack{
                if !searchText.isEmpty {
                    List {
                        ForEach(searchResults, id: \.self) { breed in
                            Button(action: {itemTapped(breed)}) {
                                Text(breed.name)
                            }
                        }
                    }
                }
            }
            PagingListView(viewModel: viewModel) { dog in
                DogsListItemView(dogsItem: dog)
            } errorView: {
                ErrorStateView(viewData:
                                EmptyStateViewData(
                                    buttonTapped: {
                                        viewModel.fetchInitial()})
                )
            } noInternetView: {
                ErrorStateView(viewData:
                                EmptyStateViewData(
                                    buttonTapped: {
                                        viewModel.fetchInitial()})
                )
            } emptyView: {
                ErrorStateView(viewData:
                                EmptyStateViewData(
                                    buttonTapped: {
                                        viewModel.fetchInitial()})
                )
            }
            
        }
        .searchable(text: $searchText)
    }
    func itemTapped(_ item: DogsItemViewData) {
        searchText = item.name
    }
    var searchResults: [DogsItemViewData] {
        if searchText.isEmpty {
            return viewModel.dogsList
        } else {
            return viewModel.dogsList.filter { $0.name.contains(searchText) }
        }
    }
}
