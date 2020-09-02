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
    var view: TopMovieViewController!
    var networkService: NetworkService!
    var topMovies: TopMovies?
    var router: Router!
    
    init(view: TopMovieViewController, networkService: NetworkService, router: Router) {
        self.view = view
        self.networkService = networkService
        self.router = router
        getTopMovies()
    }
    
    func showDetail(for movieId: String) {
        router.showDetail(movieId: movieId)
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
