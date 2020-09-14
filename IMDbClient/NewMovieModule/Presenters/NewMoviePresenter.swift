//
//  ComingPresenter.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/14/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation

protocol NewMoviePresenterProtocol {
    var comingSoonMovieCache: NewMovieData? { get set }
    var inTheatersMovieCache: NewMovieData? { get set }
    
    func downloadMovies(collectionType: NewMovieCollectionType)
}

class NewMoviePresenter: NewMoviePresenterProtocol {
    var view: ViewControllerProtocol
    var router: Router
    var networkService: NewMovieNetworkStrategy
    
    var comingSoonMovieCache: NewMovieData?
    var inTheatersMovieCache: NewMovieData?
    
    init(view: ViewControllerProtocol, router: Router, networkService: NewMovieNetworkStrategy) {
        self.view = view
        self.router = router
        self.networkService = networkService
        downloadMovies()
    }
    
    func downloadMovies(collectionType: NewMovieCollectionType = .inTheaters) {
        networkService.downloadMovies(collectionType: collectionType) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                    case .success(let movies):
                        switch collectionType {
                            case .inTheaters:
                                self.inTheatersMovieCache = movies
                                self.downloadMovies(collectionType: .inTheaters)
                            case .comingSoon:
                                self.comingSoonMovieCache = movies
                                self.view.success()
                    }
                    case .failure(let error):
                        self.view.failure(error: error)
                }
            }
        }
    }
}
