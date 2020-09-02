//
//  DetailTopMoviePresenter.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/2/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

class DetailTopMoviePresenter {
    var movieId: String
    var networkService: NetworkService!
    var view: DetailTopMovieController!
    var movie: DetailMovie!
    
    init(view: DetailTopMovieController, movieId: String, networkService: NetworkService) {
        self.movieId = movieId
        self.view = view
        self.networkService = networkService
        getM(id: movieId)
    }
    
    func getM(id: String) {
        networkService.getDetail(id: id) { [weak self] results in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch results {
                    case .success(let receivedMovies):
                        self.movie = receivedMovies
                        self.view.success()
                    case .failure(let error):
                        self.view.failure(error: error)
                }
            }
        }
    }
}
