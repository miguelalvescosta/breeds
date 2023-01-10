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
    private(set) var id: Int = 0

    init(_ item: DogsElement) {
        self.id = item.id
        self.name = item.name
        self.image = item.image.url
    }
}
