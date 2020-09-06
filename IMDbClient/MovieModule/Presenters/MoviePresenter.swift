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
    var view: ViewControllerProtocol
    var topRatedMovies: [Movie]?
    var mostPopularMovies: [Movie]?
    var router: Router
    var networkService: MovieNetworkServiceProtocol
    
    init(view: ViewControllerProtocol, networkService: MovieNetworkServiceProtocol, router: Router) {
        self.view = view
        self.networkService = networkService
        self.router = router
        loadTopRatedMovies()
        loadMostPopularMovies()
    }
    
    func tapOnTheMovie(from indexPath: IndexPath) {
        let movie = topRatedMovies![indexPath.row]
        router.showDetail(movie: movie)
    }
    
    func loadTopRatedMovies() {
        networkService.getTopRatedMovies { [weak self] results in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch results {
                    case .success(let receivedMovies):
                        self.topRatedMovies = receivedMovies!.items
                        self.view.success()
                    case .failure(let error):
                        self.view.failure(error: error)
                }
            }
        }
    }
    
    func loadMostPopularMovies() {
        networkService.getMostPopularMovies { [weak self] results in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch results {
                    case .success(let receivedMovies):
                        self.mostPopularMovies = receivedMovies!.items
                        self.view.success()
                    case .failure(let error):
                        self.view.failure(error: error)
                }
            }
        }
    }
}
