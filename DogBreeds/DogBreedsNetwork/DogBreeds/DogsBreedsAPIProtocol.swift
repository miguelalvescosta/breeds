//
//  DogsBreedsAPIProtocol.swift
//  DogBreeds
//
//  Created by Miguel Costa on 10.01.23.
//

import Foundation
public enum LoadDogsResult {
    case success([DogsElement])
    case failure(Error)
}
public protocol DogsBreedsAPIProtocol {
    func load(currentPage: Int, completion: @escaping (LoadDogsResult) -> Void)
}

public struct DogsElement: Codable {
    let weight, height: Eight
    let id: Int
    let name: String
    let bredFor, breedGroup: String?
    let lifeSpan, temperament: String?
    let origin: String?
    let referenceImageID: String?
    let image: Image
    let countryCode, description, history: String?
}

public struct Eight: Codable {
    let imperial, metric: String
}

public struct Image: Codable{
    let id: String
    let width, height: Int
    let url: String
}
