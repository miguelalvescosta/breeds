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
    func loadSearchListBreeds(completion: @escaping (LoadDogsResult) -> Void)
}

public struct DogsElement: Codable {
    let id: Int
    let name: String
    let bredFor, breedGroup: String?
    let temperament: String?
    let origin: String?
    let image: Image
    let countryCode: String?
}



public struct Image: Codable{
    let id: String
    let width, height: Int
    let url: String
}
