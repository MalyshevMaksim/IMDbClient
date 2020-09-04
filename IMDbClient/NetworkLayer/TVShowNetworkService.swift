//
//  TVShowNetworkService.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/4/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation

class TVShowNetworkService: NetworkServiceProtocol {
    func getTopRatedMovies(completion: @escaping (Result<TopMovies?, Error>) -> ()) {
        var request = URLRequest(url: URL(string: "https://imdb-api.com/en/API/Top250TVs/k_288fbjOY")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        requestTask(with: request, completion: completion)
    }
    
    func getMostPopularMovies(completion: @escaping (Result<TopMovies?, Error>) -> ()) {
        var request = URLRequest(url: URL(string: "https://imdb-api.com/en/API/MostPopularTVs/k_288fbjOY")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        requestTask(with: request, completion: completion)
    }
}
