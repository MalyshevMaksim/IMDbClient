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
    func fetchMovie(forKey: String) -> Movie?
    func fetchImage(fromUrl: String) -> UIImage?
    func fetchMovieCollection(forKey: String) -> [Movie]?
    
    func addImage(image: UIImage, fromUrl: String)
    func addMovie(movie: Movie, forKey: String)
    func addMovieCollection(forKey: String, collection: [Movie])
    
    func getCountOfMovies() -> Int
    func getCountOfCollections() -> Int
}
