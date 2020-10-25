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
    var downloader: MovieDownloaderFacadeProtocol
    var view: ViewControllerProtocol
    var router: RouterProtocol
    lazy var delegate: FilterMovieDelegate = self
    
    internal var filteredMovie: [Movie] = []
    private var searchText: String = ""
    
    init(view: ViewControllerProtocol, movieDownloader: MovieDownloaderFacadeProtocol, router: RouterProtocol) {
        self.view = view
        self.downloader = movieDownloader
        self.router = router
    }
    
    func downloadMovies() {
        downloader.search(searchText: searchText) { [unowned self] movies in
            movies != nil ? filteredMovie = movies! : filteredMovie.removeAll()
            view.success()
        }
    }
    
    func displayCell(cell: MovieCellProtocol, in section: Int, for row: Int) {
        let movie = filteredMovie[row]
        DispatchQueue.main.async {
            cell.display(title: movie.title)
            cell.display(subtitle: movie.subtitle)
        }
    }
    
    func getCountOfMovies(section: Int) -> Int {
        return filteredMovie.count
    }
    
    func showDetail(fromSection: Int, forRow: Int) {
        let movie = filteredMovie[forRow]
        router.showDetail(movieId: movie.id)
    }
}

extension MovieSearchPresenter: FilterMovieDelegate {
    func filter(_ searchController: UISearchController, didChangeSearchText text: String, in section: Int) {
        self.searchText = text.replacingOccurrences(of: " ", with: "")
        downloadMovies()
    }
}
