//
//  DogsLoader.swift
//  DogBreeds
//
//  Created by Miguel Costa on 10.01.23.
//

import Foundation
public final class DogsLoader: DogsBreedsAPIProtocol {
 
    private let client: HTTPClient

    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }

    public typealias Result = LoadDogsResult
    public typealias FilterResult = LoadFiltersDogsResult
    

    public init() {
        self.client = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    }

    public func load(currentPage: Int = 0,
                     completion: @escaping (Result) -> Void) {
        guard let url = URL(string: "https://api.thedogapi.com/v1/breeds?limit=10&page=\(currentPage)&order=RANDOM") else{ return
            completion(.failure(Error.connectivity))}

        client.get(from: url) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case let .success(data, response):
                completion(DogsLoader.map(data, from: response))
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
    
    public func loadSearchListBreeds(completion: @escaping (Result) -> Void) {
        guard let url = URL(string: "https://api.thedogapi.com/v1/breeds") else{ return
            completion(.failure(Error.connectivity))}

        client.get(from: url) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case let .success(data, response):
                completion(DogsLoader.map(data, from: response))
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
    
    public func loadFilterListBreeds(id: Int,completion: @escaping (FilterResult) -> Void) {
        guard let url = URL(string: "https://api.thedogapi.com/v1/images/search?limit=8&size=full&breed_id=\(id)") else{ return
            completion(.failure(Error.connectivity))}
        client.getAuth(from: url) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case let .success(data, response):
                completion(DogsLoader.mapFilter(data, from: response))
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }

    private static func map(_ data: Data, from response: HTTPURLResponse) -> Result {
        do {
            let items = try map(data, response)
            return .success(items)
        } catch {
            return .failure(error)
        }
    }
    
    private static func mapFilter(_ data: Data, from response: HTTPURLResponse) -> FilterResult {
        do {
            let items = try mapFilter(data, response)
            return .success(items)
        } catch {
            return .failure(error)
        }
    }
}

extension DogsLoader {
 
    private static var OK_200: Int { return 200 }

    internal static func map(_ data: Data, _ response: HTTPURLResponse) throws -> [DogsElement] {
        guard response.statusCode == OK_200,
            let response = try? JSONDecoder().decode([DogsElement].self, from: data) else {
                throw DogsLoader.Error.invalidData
        }

        return response
    }
    
    internal static func mapFilter(_ data: Data, _ response: HTTPURLResponse) throws -> [Breeds] {
        guard response.statusCode == OK_200,
              let response = try? JSONDecoder().decode([BreedsFilter].self, from: data) else {
                throw DogsLoader.Error.invalidData
        }
        var breeds = [Breeds]()
        response.compactMap{ item in breeds.append(contentsOf: item.breeds ?? [])}
       
        return breeds
    }
}


