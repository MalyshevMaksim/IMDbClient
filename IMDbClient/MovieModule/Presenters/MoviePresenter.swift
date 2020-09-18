//
//  TopMoviePresenter.swift
//  IMDbAPI
//
//  Created by Малышев Максим Алексеевич on 9/2/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

protocol MoviePresenterProtocol {
    var resources: [APIRequest] { get set }
    var networkService: NetworkService { get set }
    var view: ViewControllerProtocol { get set }
    
    func displayCell(cell: MovieCell, section: Int, forRow row: Int)
    func showDetail(section: Int, from indexPath: IndexPath)
    func refreshMovies(section: Int)
    func getCountOfMovies(section: Int) -> Int
    func downloadMovies()
}

class MoviePresenter: MoviePresenterProtocol {
    var resources: [APIRequest]
    var networkService: NetworkService
    var view: ViewControllerProtocol
    var router: Router
    
    var movieCache: [String : MovieList] = [:]
    var imageCache = NSCache<NSString, UIImage>()
    
    init(view: ViewControllerProtocol, networkService: NetworkService, resources: [APIRequest], router: Router) {
        self.view = view
        self.networkService = networkService
        self.resources = resources
        self.router = router
        downloadMovies()
    }
    
    private func getCachedMovie(section: Int, for row: Int) -> Movie? {
        guard let collectionKey = resources[section].urlRequest.url?.absoluteString else {
            fatalError("Unable")
        }
        return movieCache[collectionKey]?.items[row]
    }
    
    func showDetail(section: Int, from indexPath: IndexPath) {
        guard let movie = getCachedMovie(section: section, for: indexPath.row) else {
            fatalError("Unable")
        }
        router.showDetail(movieId: movie.id)
    }
    
    func displayCell(cell: MovieCell, section: Int, forRow row: Int) {
        guard let movie = getCachedMovie(section: section, for: row) else {
            fatalError("Unable")
        }
        cell.display(crew: "Crew: \(movie.crew)")
        cell.display(title: movie.title + " (\(movie.year))")
        cell.display(imDbRating: "⭐️  \(movie.imDbRating) IMDb")
        cell.display(ratingCount: "based on \(movie.imDbRatingCount) user ratings")
        
        if let poster = imageCache.object(forKey: movie.image as NSString) {
            cell.display(image: poster)
        }
        else {
            downloadImage(cell: cell, from: movie.image)
        }
    }
    
    func refreshMovies(section: Int) {
        downloadMovies()
    }
    
    func getCountOfMovies(section: Int) -> Int {
        guard let collectionKey = resources[section].urlRequest.url?.absoluteString else {
            fatalError("Unable")
        }
        return movieCache[collectionKey]?.items.count ?? 0
    }
    
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
