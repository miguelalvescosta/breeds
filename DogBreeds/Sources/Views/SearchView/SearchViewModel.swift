//
//  SearchViewModel.swift
//  DogBreeds
//
//  Created by Miguel Costa on 11.01.23.
//

import Foundation


final class SearchViewModel: ObservableObject, PagingViewModel {
   
    typealias Item = DogsItemViewData
    private var useCase: DogsLoader
    @Published var pagingState: PagingState = .loaded
    @Published var items: [Item] = []
    @Published var dogsList = [DogsItemViewData]()
    
    init() {
        self.useCase = DogsLoader()
    }
    func fetchSearchList() {
        fetchSearchListData()
    }
    func fetchInitial() {
        items.removeAll()
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
        fetchData()
    }
    
    func fetchSearchListData() {
        useCase.loadSearchListBreeds(completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let dogs):
                if dogs.isEmpty {
                    
                    return
                }
                
                DispatchQueue.main.async {
                 self.dogsList.append(contentsOf: dogs.map({DogsItemViewData($0)}))
                 self.pagingState = .loaded
                }
            case .failure(let error):
                self.pagingState = .error
              return
            }
        })
    }

    
    func fetchData() {
        useCase.loadSearchListBreeds(completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let dogs):
                if dogs.isEmpty {
                    
                    return
                }
                
                DispatchQueue.main.async {
                 self.dogsList.append(contentsOf: dogs.map({DogsItemViewData($0)}))
                 self.pagingState = .loaded
                }
            case .failure(let error):
                self.pagingState = .error
              return
            }
        })
    }

}
