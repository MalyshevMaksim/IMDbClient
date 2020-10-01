//
//  MovieCache.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 10/1/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import UIKit

class MovieCache {
    var movieCache: [String : MovieList] = [:]
    var imageCache = NSCache<NSString, UIImage>()
    
    func pushImage(image: UIImage, forKey: String) {
        imageCache.setObject(image, forKey: (forKey as NSString))
    }
    
    func pushMovies(movies: MovieList, key: String) {
        movieCache[key] = movies
    }
    
    func pullMovie(key: String, from row: Int) -> Movie? {
        guard let movieCollection = movieCache[key] else {
            return nil
        }
        return movieCollection.items[row]
    }
    
    func pullMovies(key: String) -> [Movie]? {
        return movieCache[key]?.items
    }
    
    func pullImage(key: String) -> UIImage? {
        return imageCache.object(forKey: key as NSString)
    }
}
