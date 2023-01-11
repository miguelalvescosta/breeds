//
//  DogsItemViewData.swift
//  DogBreeds
//
//  Created by Miguel Costa on 10.01.23.
//

import SwiftUI
struct DogsItemViewData: Equatable, Hashable, Identifiable {
    let id = UUID()
    var image: String = ""
    var name: String = ""
    var category: String = ""
    var origin: String = ""
    var temperament: String = ""
    var group: String = ""
    var Dogid: Int = 0

    init(_ item: DogsElement) {
        self.name = item.name
        self.image = {
            var imageString = ""
            if let img = item.image {
                imageString = img.url
            }
            return imageString
        }()
        self.category = item.breedGroup ?? "None"
        self.origin = item.origin ?? "None"
        self.group = item.breedGroup ?? "None"
        self.temperament = item.temperament ?? "None"
        self.Dogid = item.id
    }
}
