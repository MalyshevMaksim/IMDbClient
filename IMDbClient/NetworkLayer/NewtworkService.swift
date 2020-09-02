//
//  newtworkService.swift
//  IMDbAPI
//
//  Created by Малышев Максим Алексеевич on 9/2/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation

class NetworkService {
    func getTopMovies(completion: @escaping (Result<TopMovies?, Error>) -> ()) {
        let url = URL(string: "https://imdb-api.com/en/API/Top250Movies/k_7k80gZKE")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
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
}
