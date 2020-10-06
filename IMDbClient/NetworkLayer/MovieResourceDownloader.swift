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
    private var cache: CacheGateway
    
    init(requests: [APIRequest], networkService: NetworkService, cacheGateway: CacheGateway) {
        self.requests = requests
        self.networkService = networkService
        self.cache = cacheGateway
    }
    
    func downloadMovies(completion: @escaping (_ error: Error?) -> ()) {
        for request in requests {
            let url = request.urlRequest.url
            networkService.execute(url: url!) { (result: Result<MovieList?, Error>) in
                switch result {
                    case .success(let movies):
                        self.cache.addMovies(movies: movies!, forKey: request.urlRequest.url!.absoluteString)
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
                    self.cache.addImage(image: image!, fromUrl: imageUrl)
                    completion(image, nil)
                case .failure(let error):
                    completion(nil, error)
            }
        }
    }
    
    func searchMovies(serachText: String, completion: @escaping (_ movies: [Movie]? ,_ error: Error?) -> ()) {
        let str = (requests.first?.urlRequest.url!.absoluteString)! + serachText
        let url = URL(string: str)!
        print(str)
        
        networkService.execute(url: url) { (result: Result<MovieList?, Error>) in
            switch result {
                case .success(let movies):
                    completion(movies?.result, nil)
                case .failure(let error):
                    completion(nil, error)
            }
        }
    }
    
    func getCachedMovie(fromSection: Int, forRow: Int) -> Movie? {
        guard let key = requests[fromSection].urlRequest.url?.absoluteString else {
            return nil
        }
        return cache.fetchMovie(forKey: key, fromRow: forRow)
    }
    
    func getCachedImage(for key: String) -> UIImage? {
        return cache.fetchImage(fromUrl: key)
    }
    
    func getCachedMovies(fromSection: Int) -> [Movie]? {
        guard let key = requests[fromSection].urlRequest.url?.absoluteString else {
            return nil
        }
        return cache.fetchMovies(forKey: key)
    }
    
    func getNumberOfSection() -> Int {
        return cache.getCountOfMovies()
    }
    
    func getCountOfMovies(fromSection: Int) -> Int {
        guard let key = requests[fromSection].urlRequest.url?.absoluteString, let movies = cache.fetchMovies(forKey: key) else {
            return 0
        }
        return movies.count
    }
}
