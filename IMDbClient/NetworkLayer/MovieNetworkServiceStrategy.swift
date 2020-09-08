//
//  NetworkServiceProtocol.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/4/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation


/* The strategy for loading movies allows you not to duplicate the presenter code for TV shows and movies.
   It will be enough just to replace this strategy with another */

protocol MovieNetworkServiceStrategy {
    func downloadTopRated(completion: @escaping (Result<MovieList?, Error>) -> ())
    func downloadMostPopular(completion: @escaping (Result<MovieList?, Error>) -> ())
}

extension MovieNetworkServiceStrategy {
    func executeRequest(url: URL, completion: @escaping (Result<MovieList?, Error>) -> ()) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                let movieJson = try JSONDecoder().decode(MovieList.self, from: data!)
                completion(.success(movieJson))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
