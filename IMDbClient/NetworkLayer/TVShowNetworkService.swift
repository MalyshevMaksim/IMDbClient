//
//  TVShowNetworkService.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/4/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation

class TVShowNetworkService: MovieNetworkServiceStrategy {
    func downloadTopRated(completion: @escaping (Result<MovieList?, Error>) -> ()) {
        guard let url = URL(string: "https://imdb-api.com/en/API/Top250TVs/k_7k80gZKE") else {
            return
        }
        executeRequest(url: url, completion: completion)
    }
    
    func downloadMostPopular(completion: @escaping (Result<MovieList?, Error>) -> ()) {
        guard let url = URL(string: "https://imdb-api.com/en/API/MostPopularTVs/k_7k80gZKE") else {
            return
        }
        executeRequest(url: url, completion: completion)
    }
}
