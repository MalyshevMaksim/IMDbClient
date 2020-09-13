//
//  TopMoviePresenter.swift
//  IMDbAPI
//
//  Created by Малышев Максим Алексеевич on 9/2/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

protocol MovieCell {
    func display(image: UIImage?)
    func display(title: String)
    func display(imDbRating: String)
    func display(ratingCount: String)
    func display(crew: String)
    func startActivity()
    func stopActivity()
}

protocol MoviePresenterProtocol {
    var topRatedMovieCache: MovieList? { get set }
    var mostPopularMovieCache: MovieList? { get set }
    var networkService: MovieNetworkServiceStrategy { get set }
    
    func displayCell(cell: MovieCell, segmentIndex: Int, forRow row: Int)
    func showDetail(segmentIndex: Int, from indexPath: IndexPath)
    func refreshMovies(segmentIndex: Int)
    func getCountOfMovies(segmentIndex: Int) -> Int
    func downloadTopRated()
    func downloadMostPopular()
}

class MoviePresenter: MoviePresenterProtocol {
    var view: ViewControllerProtocol
    var networkService: MovieNetworkServiceStrategy
    var router: Router
    
    var imageCache = NSCache<NSString, UIImage>()
    var topRatedMovieCache: MovieList?
    var mostPopularMovieCache: MovieList?
    
    init(view: ViewControllerProtocol, networkService: MovieNetworkServiceStrategy, router: Router) {
        self.view = view
        self.networkService = networkService
        self.router = router
        downloadTopRated()
        downloadMostPopular()
    }
    
    private func getCachedMovie(segmentIndex: Int, for row: Int) -> Movie? {
        switch segmentIndex {
            case 0:
                return topRatedMovieCache?.items[row]
            default:
                return mostPopularMovieCache?.items[row]
        }
    }
    
    func showDetail(segmentIndex: Int, from indexPath: IndexPath) {
        guard let movie = getCachedMovie(segmentIndex: segmentIndex, for: indexPath.row) else {
            fatalError("Unable")
        }
        router.showDetail(movieId: movie.id)
    }
    
    func displayCell(cell: MovieCell, segmentIndex: Int, forRow row: Int) {
        guard let movie = getCachedMovie(segmentIndex: segmentIndex, for: row) else {
            fatalError("Unable")
        }
        cell.display(crew: "Crew: \(movie.crew)")
        cell.display(title: movie.title + " (\(movie.year))")
        cell.display(imDbRating: "⭐️  \(movie.imDbRating) IMDb")
        cell.display(ratingCount: "based on \(movie.imDbRatingCount) user ratings")
        
        
        /* We check whether the desired poster is in the cache.
           If not, then download it from the network and add it to the cache.
           Otherwise we take the poster from the cache without access to the server */
        
        if let poster = imageCache.object(forKey: movie.image as NSString) {
            cell.display(image: poster)
        }
        else {
            downloadImage(cell: cell, from: movie.image)
        }
    }
    
    func refreshMovies(segmentIndex: Int) {
        switch segmentIndex {
            case 0:
                downloadTopRated()
            default:
                downloadMostPopular()
        }
    }
    
    func getCountOfMovies(segmentIndex: Int) -> Int {
        switch segmentIndex {
            case 0:
                return topRatedMovieCache?.items.count ?? 0
            default:
                return mostPopularMovieCache?.items.count ?? 0
        }
    }
    
    func downloadTopRated() {
        networkService.downloadTopRated { [weak self] results in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch results {
                    case .success(let receivedMovies):
                        self.topRatedMovieCache = receivedMovies
                        self.view.success()
                    case .failure(let error):
                        self.view.failure(error: error)
                }
            }
        }
    }
    
    func downloadMostPopular() {
        networkService.downloadMostPopular { [weak self] results in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch results {
                    case .success(let receivedMovies):
                        self.mostPopularMovieCache = receivedMovies
                    case .failure(let error):
                        self.view.failure(error: error)
                }
            }
        }
    }
    
    // Uploading an image and adding it to the cache
    private func downloadImage(cell: MovieCell, from url: String) {
        cell.display(image: nil)
        guard let url = URL(string: url) else { fatalError("Error") }
        cell.startActivity()
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async {
                cell.display(image: image)
                cell.stopActivity()
                self.imageCache.setObject(image, forKey: (url.absoluteString as NSString))
            }
        }.resume()
    }
}
