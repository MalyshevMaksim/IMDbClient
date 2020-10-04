//
//  CacheGateway.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 10/4/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

// The caching protocol determines where to cache data
// In this application, they are cached in memory
// You can extend this protocol for caching in Core Data or Realm if needed

protocol CacheGateway {
    func fetchMovie(forKey: String, fromRow: Int) -> Movie?
    func fetchMovies(forKey: String) -> [Movie]?
    func fetchImage(fromUrl: String) -> UIImage?
    
    func addImage(image: UIImage, fromUrl: String)
    func addMovies(movies: MovieList, forKey: String)
    
    func getCountOfMovies() -> Int
}
