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
    var networkService: NetworkService { get set }
    var view: DetailViewControllerProtocol { get set }
    
    func downloadMovieDetail()
    func downloadPoster(view: MovieDetailViewProtocol)
    func configureView(view: MovieDetailViewProtocol)
}

class MovieDetailPresenter: MovieDetailPresenterProtocol {
    var resource: APIRequest
    var networkService: NetworkService
    var view: DetailViewControllerProtocol
    
    var cache: CacheGateway
    var movieDetail: Movie?
    
    init(view: DetailViewControllerProtocol, networkService: NetworkService, resource: APIRequest, cache: CacheGateway) {
        self.view = view
        self.networkService = networkService
        self.resource = resource
        self.cache = cache
        downloadMovieDetail()
    }
    
    func configureView(view: MovieDetailViewProtocol) {
        guard let movie = movieDetail else {
            return
        }
        view.display(title: movie.title)
        view.display(imDbRating: movie.imDbRating!)
        view.display(length: movie.runtimeStr ?? "Unknown")
        view.display(contentRating: movie.contentRating!)
        view.display(releaseDate: movie.year!)
        view.display(plot: movie.plot!)
        downloadPoster(view: view)
    }
    
    func downloadMovieDetail() {
        guard let url = resource.urlRequest?.url else {
            return
        }
        if let movie = isMovieCached(from: url) {
            self.movieDetail = movie
            self.view.success()
        }
        else {
            networkService.execute(url: url) { (result: Result<Movie?, Error>) in
                switch result {
                    case .success(let movieDetail):
                        self.movieDetail = movieDetail
                        self.cache.addMovie(movie: self.movieDetail!, forKey: url.absoluteString)
                        self.view.success()
                    case .failure(let error):
                        self.view.failure(error: error)
                }
            }
        }
    }
    
    func downloadPoster(view: MovieDetailViewProtocol) {
        guard let movie = movieDetail, let url = URL(string: movie.image) else {
            return
        }
        if let image = cache.fetchImage(fromUrl: movie.image) {
            view.display(image: image)
        }
        else {
            networkService.downloadImage(url: url) { (result: Result<UIImage, Error>) in
               switch result {
                   case .success(let image):
                       self.cache.addImage(image: image, fromUrl: movie.image)
                       view.display(image: image)
                   case.failure:
                       view.display(image: nil)
                }
            }
        }
    }
    
    private func isMovieCached(from url: URL) -> Movie? {
        guard let movie = cache.fetchMovie(forKey: url.absoluteString) else {
            return nil
        }
        return movie
    }
}
