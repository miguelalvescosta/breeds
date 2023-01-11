//
//  URLSessionHTTPClient.swift
//  DogBreeds
//
//  Created by Miguel Costa on 10.01.23.
//

import Foundation

public final class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    private struct UnexpectedValuesRepresentation: Error {}
    
    public func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let response = response as? HTTPURLResponse {
                completion(.success(data, response))
            } else {
                completion(.failure(UnexpectedValuesRepresentation()))
            }
        }.resume()
    }
    
    public func getAuth(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
        var request = URLRequest(url: url)
        request.setValue("live_rkpUkz7MPaEcUA6O2GltYHv4Uo2RLpShJpPXwRShtET7SgErX9FNmUvadKHf1YdM", forHTTPHeaderField: "x-api-key")
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let response = response as? HTTPURLResponse {
                completion(.success(data, response))
            } else {
                completion(.failure(UnexpectedValuesRepresentation()))
            }
        }.resume()
    }
}
