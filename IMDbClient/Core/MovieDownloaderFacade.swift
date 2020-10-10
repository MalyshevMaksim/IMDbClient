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
            guard let url = request.urlRequest.url else {
                break
            }
           
            networkService.execute(url: url) { [unowned self] (result: Result<MovieList?, Error>) in
                switch result {
                    case .success(let movies):
                        cache.addMovieCollection(forKey: url.absoluteString, collection: (movies?.result)!)
                        completion(nil)
                    case .failure(let error):
                        completion(error)
                }
            }
        }
    }
    
    func downloadPoster(posterUrl: String, completion: @escaping (_ image: UIImage?) -> ()) {
        networkService.downloadImage(url: posterUrl) { [unowned self] result in
            switch result {
                case .success(let image):
                    cache.addImage(image: image!, fromUrl: posterUrl)
                    completion(image)
                case .failure:
                    fatalError("ERROR")
            }
        }
    }
    
    func search(searchText: String, completion: @escaping (_ movies: [Movie]?) -> ()) {
        networkService.cancelAllTasks()
        let url = URL(string: requests.first!.urlRequest.url!.absoluteString + searchText)
        
        networkService.execute(url: url!) { (result: Result<MovieList?, Error>) in
            switch result {
                case .success(let movies):
                    completion(movies?.result)
                case .failure(let error):
                    print(error)
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
