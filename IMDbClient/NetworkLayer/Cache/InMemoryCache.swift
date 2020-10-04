//
//  MovieCache.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 10/1/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import UIKit

class InMemoryCache: CacheGateway {
    private var imageCache = NSCache<NSString, UIImage>()
    private var movieCache: [String : MovieList] = [:]
    
    func addImage(image: UIImage, fromUrl: String) {
        imageCache.setObject(image, forKey: (fromUrl as NSString))
    }
    
    func addMovies(movies: MovieList, forKey: String) {
        movieCache[forKey] = movies
    }
    
    func fetchMovie(forKey: String, fromRow: Int) -> Movie? {
        guard let movieCollection = movieCache[forKey] else {
            return nil
        }
        return movieCollection.result[fromRow]
    }
    
    func fetchMovies(forKey: String) -> [Movie]? {
        return movieCache[forKey]?.result
    }
    
    func fetchImage(fromUrl: String) -> UIImage? {
        return imageCache.object(forKey: fromUrl as NSString)
    }
    
    func getCountOfMovies() -> Int {
        return movieCache.count
    }
}
