//
//  DogsItemViewData.swift
//  DogBreeds
//
//  Created by Miguel Costa on 10.01.23.
//

import SwiftUI
struct DogsItemViewData {
    var image: String = ""
    var name: String = ""
    var category: String = ""
    var origin: String = ""
    var temperament: String = ""
    private(set) var id: Int = 0

    init(_ item: DogsElement) {
        self.id = item.id
        self.name = item.name
        self.image = item.image.url
        self.category = item.breedGroup ?? ""
        self.origin = item.origin ?? ""
        self.temperament = item.temperament ?? ""
    }
}
