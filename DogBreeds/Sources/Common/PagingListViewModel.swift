//
//  PagingListViewModel.swift
//  DogBreeds
//
//  Created by Miguel Costa on 11.01.23.
//

import Foundation
enum PagingState {
    case loadingInitialPage, loadingNextPage, loaded, finished, empty, error, noInternet
}

protocol PagingViewModel: ObservableObject {
    associatedtype Item: Identifiable
    
    var pagingState: PagingState { get }
    var items: [Item] { get }
    
    func fetchInitial()
    func onItemAppear(_ item: Item)
    func fetchData()
}
