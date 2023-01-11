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
    @State private var showSearch = true
    init() {
        self.viewModel = SearchViewModel()
        viewModel.fetchSearchList()
    }
    var body: some View {
        NavigationView {
            ZStack{
                
                PagingListView(viewModel: viewModel) { dog in
                    SearchListItemView(dogsItem: dog)
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
                VStack{
                    if !searchText.isEmpty && showSearch {
                        List {
                            ForEach(searchResults, id: \.self) { breed in
                                Button(action: {itemTapped(breed)}) {
                                    Text(breed.name)
                                }
                            }
                        }
                    }
                }
            }
        }.searchable(text: $searchText)
            .onChange(of: searchText) { newQuery in
                showSearch = true
            }
    }
    
    func itemTapped(_ item: DogsItemViewData) {
        searchText = item.name
        viewModel.id = item.Dogid
        showSearch = false
        viewModel.fetchInitial()
        
    }
    var searchResults: [DogsItemViewData] {
        if searchText.isEmpty {
            return viewModel.dogsList
        } else {
            return viewModel.dogsList.filter { $0.name.contains(searchText) }
        }
    }
}
