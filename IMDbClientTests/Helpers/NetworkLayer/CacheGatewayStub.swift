//
//  CacheGatewayStub.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 10/23/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

class CacheGatewayStub: CacheGateway {
    var isImageCached = false
    var isMovieCollectionCached = false
    var isMovieCached = false
    
    func addMovie(movie: Movie, forKey: String) {
        isMovieCached = true
    }
    
    func fetchMovie(forKey: String) -> Movie? {
        return nil
    }
    
    func addMovieCollection(forKey: String, collection: [Movie]) {
        isMovieCollectionCached = true
    }
    
    func fetchMovieCollection(forKey: String) -> [Movie]? {
        return nil
    }
    
    func addImage(image: UIImage, fromUrl: String) {
        isImageCached = true
    }
    
    func fetchImage(fromUrl: String) -> UIImage? {
        return nil
    }
    
    func getCountOfMovies() -> Int {
        return 0
    }
    
    func getCountOfCollections() -> Int {
        return 0
    }
}
