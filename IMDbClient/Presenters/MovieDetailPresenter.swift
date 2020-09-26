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
    var networkService: NetworkClient { get set }
    var view: DetailViewControllerProtocol { get set }
    
    func downloadMovieDetail()
    func configureView(view: MovieDetailView)
}

class MovieDetailPresenter: MovieDetailPresenterProtocol {
    var resource: APIRequest
    var networkService: NetworkClient
    var view: DetailViewControllerProtocol
    var movieDetail: MovieDetail?
    
    init(view: DetailViewControllerProtocol, networkService: APIClient, resource: APIRequest) {
        self.view = view
        self.networkService = networkService
        self.resource = resource
        downloadMovieDetail()
    }
    
    func configureView(view: MovieDetailView) {
        guard let detail = movieDetail else { return }
        
        view.display(title: detail.title)
        view.display(imDbRating: detail.imDbRating)
        view.display(length: "⏱ \(detail.runtimeStr)")
        view.display(contentRating: "🔞 \(detail.contentRating)")
        view.display(releaseDate: "🗓 \(detail.year)")
        view.display(plot: detail.plot)
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
        guard let detail = movieDetail else { return }
        
        networkService.downloadPoster(url: detail.image) { (result: Result<UIImage?, Error>) in
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
