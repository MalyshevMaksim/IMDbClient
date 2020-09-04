//
//  newtworkService.swift
//  IMDbAPI
//
//  Created by Малышев Максим Алексеевич on 9/2/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

class MovieNetworkService: NetworkServiceProtocol {
    func getTopRatedMovies(completion: @escaping (Result<TopMovies?, Error>) -> ()) {
        var request = URLRequest(url: URL(string: "https://imdb-api.com/en/API/Top250Movies/k_288fbjOY")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        requestTask(with: request, completion: completion)
    }
    
    func getMostPopularMovies(completion: @escaping (Result<TopMovies?, Error>) -> ()) {
        var request = URLRequest(url: URL(string: "https://imdb-api.com/en/API/MostPopularMovies/k_288fbjOY")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        requestTask(with: request, completion: completion)
    }
}
