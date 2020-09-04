//
//  TopMoviePresenter.swift
//  IMDbAPI
//
//  Created by Малышев Максим Алексеевич on 9/2/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

class TopMoviePresenter {
    private var view: TopMovieViewController!
    private var networkService: NetworkService!
    private var topMovies: TopMovies?
    private var router: Router!
    
    init(view: TopMovieViewController, networkService: NetworkService, router: Router) {
        self.view = view
        self.networkService = networkService
        self.router = router
        getTopMovies()
    }
    
    func showDetailMovie(from indexPath: IndexPath) {
        guard let movieId = topMovies?.items[indexPath.row].id else { return }
        router.showDetail(movieId: movieId)
    }
    
    func showMovie() {
        
    }
    
    func getCountOfMovie() -> Int {
        return topMovies?.items.count ?? 0
    }
    
    func getTopMovies() {
        networkService.getTopMovies { [weak self] results in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch results {
                    case .success(let receivedMovies):
                        self.topMovies = receivedMovies
                        self.view.success()
                    case .failure(let error):
                        self.view.failure(error: error)
                }
            }
        }
    }
}
