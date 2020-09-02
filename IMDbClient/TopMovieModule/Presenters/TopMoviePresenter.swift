//
//  TopMoviePresenter.swift
//  IMDbAPI
//
//  Created by Малышев Максим Алексеевич on 9/2/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation

class TopMoviePresenter {
    var view: TopMovieViewController!
    var networkService: NetworkService!
    var topMovies: TopMovies?
    
    init(view: TopMovieViewController, networkService: NetworkService) {
        self.view = view
        self.networkService = networkService
        getTopMovies()
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
                        self.view.failrue(error: error)
                }
            }
        }
    }
}
