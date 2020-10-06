//
//  TopMoviePresenter.swift
//  IMDbAPI
//
//  Created by Малышев Максим Алексеевич on 9/2/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

class MoviePresenter: MoviePresenterProtocol {
    var resourceDownloader: MovieResourceDownloader
    var view: ViewControllerProtocol
    var router: Router
    
    private var filteredMovie: [Movie] = []
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
    
    func displayCell(cell: MovieCell, in section: Int, for row: Int) {
        var movie: Movie
        
        if filteredMovie.isEmpty {
            guard let cachedMovie = resourceDownloader.getCachedMovie(fromSection: section, forRow: row) else { return }
            movie = cachedMovie
        }
        else {
            movie = filteredMovie[row]
        }
        
        cell.display(title: movie.title)
        cell.display(subtitle: movie.subtitle)
        
        if let poster = resourceDownloader.getCachedImage(for: movie.image) {
            cell.display(image: poster)
        }
        else {
            downloadPoster(for: cell, from: movie.image)
        }
        
        guard let imDbRating = movie.imDbRating, let imDbRatingCount = movie.imDbRatingCount else {
            cell.display(imDbRating: "⭐️ No ratings")
            cell.display(imDbRatingCount: "Ratings for this movie are not yet available")
            return
        }
        cell.display(imDbRating: "⭐️ \(imDbRating) IMDb")
        cell.display(imDbRatingCount: "based on \(imDbRatingCount) user ratings")
    }
    
    func getCountOfMovies(section: Int) -> Int {
        if filteredMovie.isEmpty {
            return resourceDownloader.getCountOfMovies(fromSection: section)
        }
        return filteredMovie.count
    }
    
    func showDetail(fromSection: Int, forRow: Int) {
        if filteredMovie.isEmpty {
            guard let movie = resourceDownloader.getCachedMovie(fromSection: fromSection, forRow: forRow) else { return }
            router.showDetail(movieId: movie.id)
        }
        else {
            let movie = filteredMovie[forRow]
            router.showDetail(movieId: movie.id)
        }
    }
}

extension MoviePresenter: FilterMovieDelegate {
    func filter(_ searchController: UISearchController, didChangeSearchText text: String, in section: Int) {
        guard let movies = resourceDownloader.getCachedMovies(fromSection: section) else {
            return
        }
        filteredMovie = movies.filter { movie -> Bool in
            return movie.title.lowercased().contains(text.lowercased())
        }
    }
}
