//
//  DogBreedsTests.swift
//  DogBreedsTests
//
//  Created by Miguel Costa on 10.01.23.
//

import XCTest
@testable import DogBreeds

final class DogBreedsTests: XCTestCase {
    func test_fetchDogsListFailure() {
        guard getJsonURL(for: "dogs-sample-error") != nil else {
            return
        }
        let model = DogsListViewModel()
        model.fetchInitial()
        XCTAssert(model.items == [])
    }
    
    func test_fetchDogsListSuccess() {
        guard getJsonURL(for: "dogs-sample-response") != nil else {
            return
        }
        let model = DogsListViewModel()
        model.fetchData()
        XCTAssert(model.items.contains{ $0.name == "Afghan Hound" } == true)
    }
   
    func test_SortDogsList() {
        guard getJsonURL(for: "dogs-sample-response") != nil else {
            return
        }
        let model = DogsListViewModel()
        model.fetchData()
        model.sortAlphabetically()
        XCTAssert(model.items[0].name == "Affenpinscher")
    }

}

extension XCTestCase {
    func getJsonURL(for name: String, fileExtension: String = "json") -> URL? {
        let bundle = Bundle(for: type(of: self))
        return bundle.url(forResource: name, withExtension: fileExtension)
    }
}
