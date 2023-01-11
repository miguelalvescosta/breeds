//
//  PagingListView.swift
//  DogBreeds
//
//  Created by Miguel Costa on 11.01.23.
//

import Foundation
import SwiftUI

struct PagingListView<Model, ItemModel,
                      Item: View,
                      ErrorView: View,
                      NoInternetView: View,
                      EmptyView: View>: View where Model: PagingViewModel {
    @ObservedObject var viewModel: Model
    var itemView: (ItemModel) -> Item
    var errorView: () -> ErrorView
    var noInternetView: () -> NoInternetView
    var emptyView: (() -> EmptyView)?
    
    var body: some View {
        ZStack {
            switch viewModel.pagingState {
            case .error:
                errorView()
            case .noInternet:
                noInternetView()
            case .empty:
                emptyView?()
            default:
                if viewModel.pagingState == .loadingInitialPage {
                    HStack {
                        ProgressListView()
                    }
                }
                ScrollView(showsIndicators: false) {
                    LazyVStack(alignment: .leading, spacing: .zero) {
                        ForEach(viewModel.items) { item in
                            if let itemModel = item as? ItemModel {
                                itemView(itemModel)
                                    .onAppear {
                                        viewModel.onItemAppear(item)
                                    }
                            }
                        }
                    }
                    if viewModel.pagingState == .loadingNextPage {
                        Spacer()
                        ProgressListView()
                    }
                    if viewModel.pagingState == .finished {
                        FooterView()
                    }
                }
            }
        }.onAppear {
            viewModel.fetchInitial()
        }
    }
}


struct ProgressListView: View {
    
    var body: some View {
        HStack {
            Spacer()
            ProgressView()
                .padding(.vertical, 12)
                .progressViewStyle(CircularProgressViewStyle())
            Spacer()
        }
    }
}
struct FooterView: View {
    
    var body: some View {
        HStack {
            Spacer()
            Text("Last item")
            Spacer()
        }
    }
}
