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
    func filter(didChangeSearchText text: String, in section: Int) -> [Movie]?
}

class MoviePresenter: MoviePresenterProtocol {
    var resourceDownloader: MovieResourceDownloader
    var view: ViewControllerProtocol
    var router: Router
    lazy var delegate: FilterMovieDelegate = self
    
    init(view: ViewControllerProtocol, resourceDownloader: MovieResourceDownloader, router: Router) {
        self.view = view
        self.resourceDownloader = resourceDownloader
        self.router = router
        downloadMovies()
    }
    
    func downloadMovies() {
        resourceDownloader.downloadMovies { error in
            DispatchQueue.main.async {
                (error == nil) ? self.view.success() : self.view.failure(error: error!)
            }
        }
    }
    
    private func downloadPoster(for cell: MovieCell, from url: String) {
        cell.display(image: nil)
        cell.startActivity()
        
        resourceDownloader.downloadAndCacheMoviePoster(imageUrl: url) { image, error in
            DispatchQueue.main.async {
                if error == nil {
                    cell.display(image: image)
                    cell.stopActivity()
                }
                else {
                    cell.display(image: nil)
                }
            }
        }
    }
    
    func displayCell(cell: MovieCell, movie: Movie) {
        cell.display(title: movie.fullTitle)
        cell.display(subtitle: movie.subtitle)
        cell.display(imDbRating: movie.imDbRating.isEmpty ? "⭐️ No ratings" : "⭐️ \(movie.imDbRating) IMDb")
        cell.display(imDbRatingCount: movie.imDbRating.isEmpty ? "Ratings for this movie are not yet available" : "based on \(movie.imDbRatingCount) user ratings")
        
        if let poster = resourceDownloader.cache.pullImage(key: movie.image) {
            cell.display(image: poster)
        }
        else {
            downloadPoster(for: cell, from: movie.image)
        }
    }
}

extension MoviePresenter: FilterMovieDelegate {
    func filter(didChangeSearchText text: String, in section: Int) -> [Movie]? {
        guard let movies = resourceDownloader.getCachedMovies(fromSection: section) else {
            return nil
        }
        return movies.filter { movie -> Bool in
            return movie.title.lowercased().contains(text.lowercased())
        }
    }
}
