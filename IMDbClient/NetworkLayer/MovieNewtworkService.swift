//
//  newtworkService.swift
//  IMDbAPI
//
//  Created by Малышев Максим Алексеевич on 9/2/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation

class MovieNetworkService: MovieNetworkServiceProtocol {
    func getTopRatedMovies(completion: @escaping (Result<TopMovies?, Error>) -> ()) {
        let request = URLRequest(url: URL(string: "https://imdb-api.com/en/API/Top250Movies/k_7k80gZKE")!,timeoutInterval: Double.infinity)
        requestTask(with: request, completion: completion)
    }
    
    func getMostPopularMovies(completion: @escaping (Result<TopMovies?, Error>) -> ()) {
        let request = URLRequest(url: URL(string: "https://imdb-api.com/en/API/MostPopularMovies/k_7k80gZKE")!,timeoutInterval: Double.infinity)
        requestTask(with: request, completion: completion)
    }
}
