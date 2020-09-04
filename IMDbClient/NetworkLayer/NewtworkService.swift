//
//  newtworkService.swift
//  IMDbAPI
//
//  Created by Малышев Максим Алексеевич on 9/2/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

class NetworkService {
    func getTopMovies(completion: @escaping (Result<TopMovies?, Error>) -> ()) {
        var request = URLRequest(url: URL(string: "https://imdb-api.com/en/API/Top250Movies/k_7k80gZKE")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
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
        }.resume()
    }
    
    func getDetail(id: String, completion: @escaping (Result<DetailMovie?, Error>) -> ()) {
        var request = URLRequest(url: URL(string: "https://imdb-api.com/en/API/Title/k_288fbjOY/\(id)")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                let movieJson = try JSONDecoder().decode(DetailMovie.self, from: data!)
                completion(.success(movieJson))
            }
            catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
