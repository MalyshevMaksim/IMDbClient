//
//  MoviePresenterProtocol.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 10/1/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation

protocol MoviePresenterProtocol {
    var resourceDownloader: MovieResourceDownloader { get }
    var view: ViewControllerProtocol { get }
    var delegate: FilterMovieDelegate { get set }
    var router: Router { get }
    
    func displayCell(cell: MovieCell, movie: Movie)
    func downloadMovies()
}

extension MoviePresenterProtocol {
    func getCountOfMovies(section: Int) -> Int {
        return resourceDownloader.getCountOfMovies(fromSection: section)
    }
    
    func showDetail(id: String) {
        router.showDetail(movieId: id)
    }
}
