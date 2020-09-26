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
    var resource: APIRequest { get set }
    var networkService: NetworkServiceClient { get set }
    var view: DetailViewControllerProtocol { get set }
    
    func downloadMovieDetail()
    func configureView(view: MovieDetailView)
}

class MovieDetailPresenter: MovieDetailPresenterProtocol {
    var resource: APIRequest
    var networkService: NetworkServiceClient
    var view: DetailViewControllerProtocol
    var movieDetail: MovieDetail!
    
    init(view: DetailViewControllerProtocol, networkService: NetworkServiceClient, resource: APIRequest) {
        self.view = view
        self.networkService = networkService
        self.resource = resource
        downloadMovieDetail()
    }
    
    func configureView(view: MovieDetailView) {
        view.display(title: movieDetail.title)
        view.display(imDbRating: movieDetail.imDbRating)
        view.display(length: "⏱ \(movieDetail.runtimeStr)")
        view.display(contentRating: "🔞 \(movieDetail.contentRating)")
        view.display(releaseDate: "🗓 \(movieDetail.year)")
        view.display(plot: movieDetail.plot)
        downloadPoster(view: view)
    }
    
    func downloadMovieDetail() {
        networkService.execute(request: resource) { (result: Result<MovieDetail?, Error>) in
            DispatchQueue.main.async {
                switch result {
                    case .success(let movieDetail):
                        self.movieDetail = movieDetail
                        self.view.success()
                    case .failure(let error):
                        print(error)
                }
            }
        }
    }
    
    private func downloadPoster(view: MovieDetailView) {
        networkService.downloadPoster(url: movieDetail.image) { (result: Result<UIImage?, Error>) in
            DispatchQueue.main.async {
                switch result {
                    case .success(let image):
                        view.display(image: image)
                    case.failure:
                        view.display(image: nil)
                }
            }
        }
    }
}
