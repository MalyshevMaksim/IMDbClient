//
//  MovieSearchController.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 10/5/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

class MovieSearchPresenter: MoviePresenterProtocol {
    var resourceDownloader: MovieDownloaderFacade
    var view: ViewControllerProtocol
    var router: Router
    lazy var delegate: FilterMovieDelegate = self
    
    private var foundMovies: [Movie] = []
    private var searchText: String = ""
    
    init(view: ViewControllerProtocol, resourceDownloader: MovieDownloaderFacade, router: Router) {
        self.view = view
        self.resourceDownloader = resourceDownloader
        self.router = router
    }
    
    func displayCell(cell: MovieCellProtocol, in section: Int, for row: Int) {
        let movie = foundMovies[row]
        cell.display(title: movie.title)
        cell.display(subtitle: movie.subtitle)
    }
    
    func showDetail(fromSection: Int, forRow: Int) {
        let movie = foundMovies[forRow]
        router.showDetail(movieId: movie.id)
    }
    
    func getCountOfMovies(section: Int) -> Int {
        return foundMovies.count
    }
    
    func downloadMovies() {
        resourceDownloader.search(searchText: searchText) { movies in
            movies != nil ? self.foundMovies = movies! : self.foundMovies.removeAll()
            self.view.success()
        }
    }
}

extension MovieSearchPresenter: FilterMovieDelegate {
    func filter(_ searchController: UISearchController, didChangeSearchText text: String, in section: Int) {
        self.searchText = text
        downloadMovies()
    }
}
