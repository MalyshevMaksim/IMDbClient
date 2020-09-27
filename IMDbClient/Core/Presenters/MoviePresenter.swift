//
//  TopMoviePresenter.swift
//  IMDbAPI
//
//  Created by Малышев Максим Алексеевич on 9/2/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

protocol FilterMovieDelegate {
    func filter(didChangeSearchText text: String, in section: Int)
    func filterShouldChange(filtering: Bool)
}

protocol MoviePresenterProtocol {
    var resources: [APIRequest] { get set }
    var networkService: NetworkService { get set }
    var view: ViewControllerProtocol { get set }
    var delegate: FilterMovieDelegate { get set }
    
    func displayCell(cell: MovieCell, section: Int, forRow row: Int)
    func showDetail(section: Int, from indexPath: IndexPath)
    func getCountOfMovies(section: Int) -> Int
    func downloadMovies()
}

class MoviePresenter: MoviePresenterProtocol {
    var resources: [APIRequest]
    var networkService: NetworkService
    var view: ViewControllerProtocol
    lazy var delegate: FilterMovieDelegate = self
    
    var movieCache: [String : MovieList] = [:]
    var imageCache = NSCache<NSString, UIImage>()
    
    var router: Router
    var isFiltering = false
    var filteredMovies: [Movie] = []
    
    init(view: ViewControllerProtocol, networkService: NetworkService, resources: [APIRequest], router: Router) {
        self.view = view
        self.networkService = networkService
        self.resources = resources
        self.router = router
        downloadMovies()
    }
    
    private func getCachedMovie(section: Int, for row: Int) -> Movie? {
        if isFiltering {
            return filteredMovies[row]
        }
        guard let collectionKey = resources[section].urlRequest.url?.absoluteString else { return nil }
        return movieCache[collectionKey]?.items[row]
    }
    
    func getCountOfMovies(section: Int) -> Int {
        if isFiltering {
            return filteredMovies.count
        }
        guard let collectionKey = resources[section].urlRequest.url?.absoluteString else { return 0 }
        return movieCache[collectionKey]?.items.count ?? 0
    }
    
    func showDetail(section: Int, from indexPath: IndexPath) {
        guard let movie = getCachedMovie(section: section, for: indexPath.row) else { return }
        router.showDetail(movieId: movie.id)
    }
    
    func displayCell(cell: MovieCell, section: Int, forRow row: Int) {
        guard let movie = getCachedMovie(section: section, for: row) else { return }
          
        cell.display(title: movie.fullTitle)
        cell.display(subtitle: movie.subtitle)
        
        if movie.imDbRating == "" {
            cell.display(imDbRating: "⭐️ No ratings")
            cell.display(imDbRatingCount: "Ratings for this movie are not yet available.")
        }
        else {
            cell.display(imDbRating: "⭐️ \(movie.imDbRating) IMDb")
            cell.display(imDbRatingCount: "based on \(movie.imDbRatingCount) user ratings")
        }
        
        // We get the movie poster from the cache if it is there.
        // Otherwise, we download the image from the network and put it in the cache
        if let poster = imageCache.object(forKey: movie.image as NSString) {
            cell.display(image: poster)
        }
        else {
            downloadAndCacheMoviePoster(cell: cell, imageUrl: movie.image)
        }
    }
    
    // Loading data from all resources
    func downloadMovies() {
        for resource in resources {
            networkService.execute(request: resource) { (result: Result<MovieList?, Error>) in
                DispatchQueue.main.async {
                    switch result {
                        case .success(let movies):
                            self.movieCache[resource.urlRequest.url!.absoluteString] = movies
                            self.view.success()
                        case .failure(let error):
                            self.view.failure(error: error)
                    }
                }
            }
        }
    }
    
    private func downloadAndCacheMoviePoster(cell: MovieCell, imageUrl: String) {
        cell.display(image: nil)
        cell.startActivity()
        
        networkService.downloadPoster(url: imageUrl) { result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let image):
                        cell.display(image: image)
                        cell.stopActivity()
                        self.imageCache.setObject(image!, forKey: (imageUrl as NSString))
                    case .failure:
                        cell.display(image: nil)
                }
            }
        }
    }
}

extension MoviePresenter: FilterMovieDelegate {
    func filter(didChangeSearchText text: String, in section: Int) {
        guard let collectionKey = resources[section].urlRequest.url?.absoluteString, let movies = movieCache[collectionKey] else {
            return
        }
        filteredMovies = movies.items.filter { movie -> Bool in
            return movie.title.lowercased().contains(text.lowercased())
        }
    }
    
    func filterShouldChange(filtering: Bool) {
        self.isFiltering = filtering
    }
}
