//
//  DogsListViewModel.swift
//  DogBreeds
//
//  Created by Miguel Costa on 10.01.23.
//

import Foundation


final class DogsListViewModel: ObservableObject, PagingViewModel { 
    typealias Item = DogsItemViewData
    
    private var useCase: DogsLoader
    var arrangementIds: [String]?
    private var currentPage = 0
    private var pageSize = 25
    @Published var pagingState: PagingState = .loaded
    @Published var items: [Item] = []
    
    init() {
        self.useCase = DogsLoader()
    }
    
    func fetchInitial() {
        items.removeAll()
        currentPage = 0
        pagingState = .loadingInitialPage
        fetchData()
    }
    
    func onItemAppear(_ item: Item) {
        if pagingState == .loadingInitialPage ||
            pagingState == .loadingNextPage ||
            pagingState == .finished {
            return
        }
        guard let lastItem = items.last, item.id == lastItem.id else {
            return
        }
        pagingState = .loadingNextPage
        currentPage += 1
        fetchData()
    }
    func sortAlphabetically(){
        var sortedItems = items
        sortedItems.sort { lhs, rhs in
            lhs.name < rhs.name
        }
        if sortedItems.isEmpty {
            return
        }else{
            items = sortedItems
        }
    }
    
    func fetchData() {
        useCase.load(currentPage: currentPage, completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let dogs):
                if dogs.isEmpty {
                    self.pagingState = self.items.isEmpty ? .empty : .finished
                    return
                }
                
                DispatchQueue.main.async {
                    self.items.append(contentsOf: dogs.map({DogsItemViewData($0)}))
                    self.pagingState = .loaded
                }
            case .failure(let error):
                self.handle(error: error)
            }
        })
    }
    
    func handle(error: Error) {
        DispatchQueue.main.async {
            self.pagingState = .error
        }
    }
}
