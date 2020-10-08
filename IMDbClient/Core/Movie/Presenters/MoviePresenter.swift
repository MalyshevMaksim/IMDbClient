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
    var resourceDownloader: MovieDownloaderFacade
    var view: ViewControllerProtocol
    var router: Router
    
    private var filteredMovie: [Movie] = []
    lazy var delegate: FilterMovieDelegate = self
    
    init(view: ViewControllerProtocol, resourceDownloader: MovieDownloaderFacade, router: Router) {
        self.view = view
        self.resourceDownloader = resourceDownloader
        self.router = router
        downloadMovies()
    }
    
    func downloadMovies() {
        resourceDownloader.download() { error in
            DispatchQueue.main.async {
                (error == nil) ? self.view.success() : self.view.failure(error: error!)
            }
        }
    }
    
    func displayCell(cell: MovieCellProtocol, in section: Int, for row: Int) {
        var movie: Movie
        
        if filteredMovie.isEmpty {
            guard let movieCollection = resourceDownloader.getCachedMovies(fromSection: section) else { return }
            movie = movieCollection[row]
        }
        else {
            movie = filteredMovie[row]
        }
        
        DispatchQueue.main.async {
            cell.display(title: movie.title)
            cell.display(subtitle: movie.subtitle)
        
            if let image = self.resourceDownloader.getCachedImage(for: movie.image) {
                cell.display(image: image)
            }
            else {
                cell.display(image: nil)
            }
            
            guard let imDbRating = movie.imDbRating, imDbRating != "", let imDbRatingCount = movie.imDbRatingCount, imDbRatingCount != "" else {
                cell.display(imDbRating: "⭐️ No ratings")
                cell.display(imDbRatingCount: "Ratings for this movie are not yet available")
                return
            }
            cell.display(imDbRating: "⭐️ \(imDbRating) IMDb")
            cell.display(imDbRatingCount: "based on \(imDbRatingCount) user ratings")
        }
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
