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
    var downloader: MovieDownloaderFacadeProtocol
    var view: ViewControllerProtocol
    var router: RouterProtocol
    var filteredMovie: [Movie] = []
    lazy var delegate: FilterMovieDelegate = self
    
    init(view: ViewControllerProtocol, movieDownloader: MovieDownloaderFacadeProtocol, router: RouterProtocol) {
        self.view = view
        self.downloader = movieDownloader
        self.router = router
        downloadMovies()
    }
    
    func downloadMovies() {
        downloader.download { error in
            error == nil ? self.view.success() : self.view.failure(error: error!)
        }
    }
    
    func displayCell(cell: MovieCellProtocol, in section: Int, for row: Int) {
        guard let movie = getMovie(in: section, for: row) else {
            return
        }
        DispatchQueue.main.async {
            cell.startActivity()
            cell.display(title: movie.title)
            cell.display(subtitle: movie.subtitle)
            self.displayPoster(for: cell, url: movie.image)
            
            guard let imDbRating = movie.imDbRating, !imDbRating.isEmpty, let imDbRatingCount = movie.imDbRatingCount, !imDbRatingCount.isEmpty else {
                cell.display(imDbRating: "⭐️ No ratings")
                cell.display(imDbRatingCount: "Ratings for this movie are not yet available")
                return
            }
            cell.display(imDbRating: "⭐️ \(imDbRating) IMDb")
            cell.display(imDbRatingCount: "based on \(imDbRatingCount) user ratings")
        }
    }
    
    private func getMovie(in section: Int, for row: Int) -> Movie? {
        if filteredMovie.isEmpty {
            guard let movieCollection = downloader.getCachedMovies(fromSection: section) else {
                return nil
            }
            return movieCollection[row]
        }
        else {
            return filteredMovie[row]
        }
    }
    
    private func displayPoster(for cell: MovieCellProtocol, url: String) {
        if let image = downloader.getCachedImage(for: url) {
            cell.display(image: image)
        }
        else {
            downloader.downloadPoster(posterUrl: url) { image in
                cell.display(image: image)
            }
        }
        cell.stopActivity()
    }
    
    func getCountOfMovies(section: Int) -> Int {
        if filteredMovie.isEmpty {
            return downloader.getCountOfMovies(fromSection: section)
        }
        return filteredMovie.count
    }
    
    func showDetail(fromSection: Int, forRow: Int) {
        var movie: Movie
        
        if filteredMovie.isEmpty {
            guard let cachedMovie = downloader.getCachedMovie(fromSection: fromSection, forRow: forRow) else {
                return
            }
            movie = cachedMovie
        }
        else {
            movie = filteredMovie[forRow]
        }
        router.showDetail(movieId: movie.id)
    }
}

extension MoviePresenter: FilterMovieDelegate {
    func filter(_ searchController: UISearchController, didChangeSearchText text: String, in section: Int) {
        guard let movies = downloader.getCachedMovies(fromSection: section) else {
            return
        }
        filteredMovie = movies.filter { movie -> Bool in
            return movie.title.lowercased().contains(text.lowercased())
        }
    }
}
