//
//  NewMovieNetworkService.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/14/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation

enum NewMovieCollectionType {
    case comingSoon, inTheaters
    
    var url: String {
        switch self {
        case .comingSoon:
            return "https://imdb-api.com/en/API/ComingSoon/k_7k80gZKE"
        default:
            return "https://imdb-api.com/en/API/InTheaters/k_7k80gZKE"
        }
    }
}

protocol NewMovieNetworkStrategy {
    func downloadMovies(collectionType: NewMovieCollectionType, completion: @escaping (Result<NewMovieData?, Error>) -> ())
}

class NewMovieNetworkService: NewMovieNetworkStrategy {
    func downloadMovies(collectionType: NewMovieCollectionType, completion: @escaping (Result<NewMovieData?, Error>) -> ()) {
        guard let url = URL(string: collectionType.url) else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            do {
                let movieJson = try JSONDecoder().decode(NewMovieData.self, from: data!)
                completion(.success(movieJson))
            }
            catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
