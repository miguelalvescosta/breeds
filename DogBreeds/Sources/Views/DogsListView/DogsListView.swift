//
//  DogsListView.swift
//  DogBreeds
//
//  Created by Miguel Costa on 10.01.23.
//


import SwiftUI

struct DogsListView: View {
    @ObservedObject var viewModel: DogsListViewModel
    
    init() {
        self.viewModel = DogsListViewModel()
    }
    
    var body: some View {
        NavigationView {
            VStack{
            Button("order alphabetically") {
                viewModel.sortAlphabetically()
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
        }
    }
    
}
