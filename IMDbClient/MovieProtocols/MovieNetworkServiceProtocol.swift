//
//  NetworkServiceProtocol.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/4/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation

protocol MovieNetworkServiceProtocol {
    func getTopRatedMovies(completion: @escaping (Result<TopMovies?, Error>) -> ())
    func getMostPopularMovies(completion: @escaping (Result<TopMovies?, Error>) -> ())
}

extension MovieNetworkServiceProtocol {
    func requestTask(with request: URLRequest, completion: @escaping (Result<TopMovies?, Error>) -> ()) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                let movieJson = try JSONDecoder().decode(TopMovies.self, from: data!)
                completion(.success(movieJson))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
