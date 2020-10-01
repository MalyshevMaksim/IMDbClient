//
//  ResourceDownloader.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 10/1/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import UIKit

class MovieResourceDownloader {
    private var requests: [APIRequest]
    private var networkService: NetworkService
    var cache = MovieCache()
    
    init(resources: [APIRequest], networkService: NetworkService) {
        self.requests = resources
        self.networkService = networkService
    }
    
    func downloadMovies(completion: @escaping (_ error: Error?) -> ()) {
        for request in requests {
            networkService.execute(request: request) { (result: Result<MovieList?, Error>) in
                switch result {
                    case .success(let movies):
                        self.cache.pushMovies(movies: movies!, key: request.urlRequest.url!.absoluteString)
                        completion(nil)
                    case .failure(let error):
                        completion(error)
                }
            }
        }
    }
    
    func downloadAndCacheMoviePoster(imageUrl: String, completion: @escaping (_ image: UIImage?, _ error: Error?) -> ()) {
        networkService.downloadImage(url: imageUrl) { result in
            switch result {
                case .success(let image):
                    self.cache.pushImage(image: image!, forKey: imageUrl)
                    completion(image, nil)
                case .failure(let error):
                    completion(nil, error)
            }
        }
    }
    
    func getCachedMovie(fromSection: Int, forRow: Int) -> Movie? {
        guard let key = requests[fromSection].urlRequest.url?.absoluteString else {
            return nil
        }
        return cache.pullMovie(key: key, from: forRow)
    }
    
    func getCachedMovies(fromSection: Int) -> [Movie]? {
        guard let key = requests[fromSection].urlRequest.url?.absoluteString else {
            return nil
        }
        return cache.pullMovies(key: key)
    }
    
    func getCountOfMovies(fromSection: Int) -> Int {
        guard let key = requests[fromSection].urlRequest.url?.absoluteString, let movies = cache.movieCache[key]?.items else {
            return 0
        }
        return movies.count
    }
}
