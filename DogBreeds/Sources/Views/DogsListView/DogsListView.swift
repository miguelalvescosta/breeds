//
//  DogsListView.swift
//  DogBreeds
//
//  Created by Miguel Costa on 10.01.23.
//


import SwiftUI

struct DogsListView: View {
    @ObservedObject var viewModel: DogsListViewModel
    
    init(viewModel: DogsListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
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
