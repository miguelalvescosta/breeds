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
    var id = 1
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
            case .failure(_):
                DispatchQueue.main.async {
                    self.pagingState = .error
                }
                return
            }
        })
    }
    
    
    func fetchData() {
        useCase.loadFilterListBreeds(id: id, completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let dogs):
                DispatchQueue.main.async {
                    let listDogsElement = dogs.compactMap{ item in DogsElement(id: item.id,
                                                                               name: item.name ?? "",
                                                                               bredFor: nil,
                                                                               breedGroup: item.breed_group ?? "",
                                                                               temperament: item.temperament,
                                                                               origin: item.origin,
                                                                               image: nil,
                                                                               countryCode: nil)}
                    self.items.append(contentsOf: listDogsElement.map({DogsItemViewData($0)}))
                    self.pagingState = .finished
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.pagingState = .error
                    return
                }}
        })
    }
    
}
