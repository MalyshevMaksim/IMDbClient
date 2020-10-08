//
//  ResourceDownloader.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 10/1/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import UIKit

final class MovieDownloaderFacade {
    private var requests: [APIRequest]
    private var networkService: NetworkService
    private var cache: CacheGateway
    
    init(requests: [APIRequest], networkService: NetworkService, cacheGateway: CacheGateway) {
        self.requests = requests
        self.networkService = networkService
        self.cache = cacheGateway
    }
    
    func download(completion: @escaping (_ error: Error?) -> ()) {
        for request in requests {
            guard let url = request.urlRequest.url else { break }
            networkService.execute(url: url) { (result: Result<MovieList?, Error>) in
                switch result {
                    case .success(let movies):
                        self.addToCache(movies!, key: url.absoluteString, quality: self.networkService.quality)
                        completion(nil)
                    case .failure(let error):
                        completion(error)
                }
            }
        }
    }
    
    private func addToCache(_ movies: MovieList, key: String, quality: PosterEndpoint) {
        guard let movies = movies.result else { return }
        cache.addMovieCollection(forKey: key, collection: movies)
        for movie in movies {
            downloadPoster(posterUrl: movie.image, quality: quality)
        }
    }
    
    private func downloadPoster(posterUrl: String, quality: PosterEndpoint) {
        networkService.downloadImage(url: posterUrl, quality: quality) { result in
            switch result {
                case .success(let image):
                    self.cache.addImage(image: image!, fromUrl: posterUrl)
                case .failure:
                    fatalError("ERROR")
            }
        }
    }
    
    func getCachedMovie(fromSection: Int, forRow: Int) -> Movie? {
        guard let collection = getCachedMovies(fromSection: fromSection) else {
            return nil
        }
        return collection[forRow]
    }
    
    func getCachedMovies(fromSection: Int) -> [Movie]? {
        guard let key = requests[fromSection].urlRequest.url?.absoluteString else {
            return nil
        }
        return cache.fetchMovieCollection(forKey: key)
    }
    
    func getCachedImage(for key: String) -> UIImage? {
        return cache.fetchImage(fromUrl: key)
    }
    
    func getNumberOfSection() -> Int {
        return cache.getCountOfCollections()
    }
    
    func getCountOfMovies(fromSection: Int) -> Int {
        guard let key = requests[fromSection].urlRequest.url?.absoluteString, let movies = cache.fetchMovieCollection(forKey: key) else {
            return 0
        }
        return movies.count
    }
}
