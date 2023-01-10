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
        ZStack {
            switch viewModel.pagingState {
            case .error:
                ErrorStateView(viewData:
                                EmptyStateViewData(
                                    title: "Error",
                                    subtitle: "Error",
                                    buttonTitle: "Retry",
                                    buttonTapped: {
                                        viewModel.retrieveDogs()
                                    })
                )
            case .noInternet:
                ErrorStateView(viewData:
                                EmptyStateViewData(
                                    title: "Error",
                                    subtitle: "Error",
                                    buttonTitle: "Retry",
                                    buttonTapped: {
                                        viewModel.retrieveDogs()
                                    })
                )
            case .empty:
                ErrorStateView(viewData:
                                EmptyStateViewData(
                                    title: "Error",
                                    subtitle: "Error",
                                    buttonTitle: "Retry",
                                    buttonTapped: {
                                        viewModel.retrieveDogs()
                                    })
                )
            default:
                if viewModel.pagingState == .loadingInitialPage {
                    HStack {
                        Spacer()
                        ProgressView()
                            .padding(.vertical, 12)
                            .progressViewStyle(CircularProgressViewStyle())
                        Spacer()
                    }
                }
                ScrollView(showsIndicators: false) {
                    LazyVStack(alignment: .leading, spacing: .zero) {
                        ForEach(Array(viewModel.dogsList.enumerated()), id: \.0) { _, dog in
                            DogsListItemView(dogsItem: dog)
                                .onAppear {
                                    viewModel.onItemAppear(item: dog)
                                }
                        }
                        if viewModel.pagingState == .loadingNextPage {
                            HStack {
                                Spacer()
                                ProgressView()
                                    .padding(.vertical, 12)
                                    .progressViewStyle(CircularProgressViewStyle())
                                Spacer()
                            }
                        }
                        if viewModel.pagingState == .finished {
                            HStack {
                                Spacer()
                                ProgressView()
                                Text("No more Dogs")
                                Spacer()
                            }
                        }
                    }
                }
            }
        }.onAppear {
            viewModel.retrieveDogs()
        }
    }
    
}
