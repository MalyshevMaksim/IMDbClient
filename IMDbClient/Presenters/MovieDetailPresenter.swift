//
//  DetailTopMoviePresenter.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/2/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

protocol MovieDetailPresenterProtocol {
    var movieDetail: MovieDetail! { get set }
    var networkService: NetworkServiceClient { get set }
    func downloadMovieDetail()
    func configureView(view: MovieDetailView)
}

class MovieDetailPresenter: MovieDetailPresenterProtocol {
    var networkService: NetworkServiceClient
    var view: ViewControllerProtocol
    var movieDetail: MovieDetail!
    
    init(view: ViewControllerProtocol, networkService: NetworkServiceClient) {
        self.view = view
        self.networkService = networkService
        downloadMovieDetail()
    }
    
    func configureView(view: MovieDetailView) {
        view.display(title: movieDetail.title)
        view.display(imDbRating: movieDetail.imDbRating)
        view.display(length: "⏱ \(movieDetail.imDbRating)")
        view.display(contentRating: "🔞 \(movieDetail.contentRating)")
        view.display(releaseDate: "🗓 \(movieDetail.year)")
        view.display(plot: movieDetail.plot)
    }
    
    func downloadMovieDetail() {
        networkService.execute(request: <#T##APIRequest#>) { (Result<MovieDetail?, Error>) in
            
        }
    }
}
