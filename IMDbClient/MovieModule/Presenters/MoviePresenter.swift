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
    var topRated: MovieList?
    var mostPopular: MovieList?
    var router: Router
    var networkService: MovieNetworkServiceStrategy
    
    init(view: ViewControllerProtocol, networkService: MovieNetworkServiceStrategy, router: Router) {
        self.view = view
        self.networkService = networkService
        self.router = router
        downloadTopRated()
        downloadMostPopular()
    }
    
    func tapOnTheMovie(from indexPath: IndexPath) {
        let movie = topRated!.items[indexPath.row]
        router.showDetail(movieId: movie.id)
    }
    
    func downloadTopRated() {
        networkService.downloadTopRated { [weak self] results in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch results {
                    case .success(let receivedMovies):
                        self.topRated = receivedMovies
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
                        self.mostPopular = receivedMovies
                        self.view.success()
                    case .failure(let error):
                        self.view.failure(error: error)
                }
            }
        }
    }
}
