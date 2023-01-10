//
//  DogsListViewModel.swift
//  DogBreeds
//
//  Created by Miguel Costa on 10.01.23.
//

import Foundation


final class DogsListViewModel: ObservableObject {
    enum PagingState {
        case loadingInitialPage, loadingNextPage, loaded, finished, empty, error, noInternet
    }
    
    private var useCase: DogsLoader
    var arrangementIds: [String]?
    private var currentPage = 0
    private var pageSize = 25
    @Published var pagingState: PagingState = .loaded
    @Published var dogsList = [DogsItemViewData]()
    
    init() {
        self.useCase = DogsLoader()
    }

    func retrieveDogs() {
        dogsList.removeAll()
        pagingState = .loadingInitialPage
        currentPage = 0
        getDogsList()
    }

    
    func onItemAppear(item: DogsItemViewData) {

        if pagingState == .loadingInitialPage ||
            pagingState == .loadingNextPage ||
            pagingState == .finished {
            return
        }

        guard let index = dogsList.firstIndex(where: { $0.id == item.id }) else {
            return
        }

        guard index == dogsList.endIndex - 1 else {
            return
        }

        pagingState = .loadingNextPage
        currentPage += 1
        getDogsList()
    }

    func getDogsList() {
        useCase.load(currentPage: currentPage, completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let dogs):
                if dogs.isEmpty {
                    self.pagingState = self.dogsList.isEmpty ? .empty : .finished
                    return
                }
                self.dogsList.append(contentsOf: dogs.map({DogsItemViewData($0)}))
                self.pagingState = .loaded
            case .failure(let error):
                self.handle(error: error)
            }
        })
    }
    
    func handle(error: Error) {
        self.pagingState = .error
    }
}
