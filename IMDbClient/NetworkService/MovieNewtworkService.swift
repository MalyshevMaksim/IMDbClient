//
//  newtworkService.swift
//  IMDbAPI
//
//  Created by Малышев Максим Алексеевич on 9/2/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation

class MovieNetworkService: NSObject, MovieNetworkServiceStrategy {
    func downloadTopRated(completion: @escaping (Result<MovieList?, Error>) -> ()) {
        guard let url = URL(string: "https://imdb-api.com/en/API/Top250Movies/k_288fbjOY") else {
            return
        }
        executeRequest(url: url, completion: completion)
    }
    
    func downloadMostPopular(completion: @escaping (Result<MovieList?, Error>) -> ()) {
        guard let url = URL(string: "https://imdb-api.com/en/API/MostPopularMovies/k_288fbjOY") else {
            return
        }
        executeRequest(url: url, completion: completion)
    }
}
