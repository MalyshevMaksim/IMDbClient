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
    private var movieCache: [String : Movie] = [:]
    private var movieCollection: [String : [Movie]] = [:]
    
    func addMovie(movie: Movie, forKey: String) {
        movieCache[forKey] = movie
    }
    
    func fetchMovie(forKey: String) -> Movie? {
        return movieCache[forKey]
    }
    
    func addMovieCollection(forKey: String, collection: [Movie]) {
        movieCollection[forKey] = collection
    }
    
    func fetchMovieCollection(forKey: String) -> [Movie]? {
        return movieCollection[forKey]
    }
    
    func addImage(image: UIImage, fromUrl: String) {
        imageCache.setObject(image, forKey: (fromUrl as NSString))
    }
    
    func fetchImage(fromUrl: String) -> UIImage? {
        return UIImage()
    }
    
    func getCountOfMovies() -> Int {
        return movieCache.count
    }
    
    func getCountOfCollections() -> Int {
        return movieCollection.count
    }
}
