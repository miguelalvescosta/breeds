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
public enum LoadFiltersDogsResult {
    case success([Breeds])
    case failure(Error)
}

public protocol DogsBreedsAPIProtocol {
    func load(currentPage: Int, completion: @escaping (LoadDogsResult) -> Void)
    func loadSearchListBreeds(completion: @escaping (LoadDogsResult) -> Void)
    func loadFilterListBreeds(id: Int,completion: @escaping (LoadFiltersDogsResult) -> Void)
}

public struct DogsElement: Codable {
    let id: Int
    let name: String
    let bredFor, breedGroup: String?
    let temperament: String?
    let origin: String?
    let image: Image?
    let countryCode: String?
}



public struct Image: Codable{
    let id: String
    let width, height: Int
    let url: String
}
struct BreedsFilter : Codable {
    let breeds : [Breeds]?
    let id : String
    let url : String?
    let width : Int?
    let height : Int?
}

public struct Breeds : Codable {

    let id : Int
    let name : String?
    let bred_for : String?
    let breed_group : String?
    let life_span : String?
    let temperament : String?
    let origin : String?
    let reference_image_id : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case bred_for = "bred_for"
        case breed_group = "breed_group"
        case life_span = "life_span"
        case temperament = "temperament"
        case origin = "origin"
        case reference_image_id = "reference_image_id"
    }
}
