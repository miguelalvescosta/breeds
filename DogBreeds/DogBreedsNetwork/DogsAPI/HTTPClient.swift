//
//  HTTPClient.swift
//  DogBreeds
//
//  Created by Miguel Costa on 10.01.23.
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
    func getAuth(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}

