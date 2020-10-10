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
        guard let detail = movieDetail else { return }
        
        DispatchQueue.main.async {
            view.display(title: detail.title)
            view.display(imDbRating: detail.imDbRating!)
            view.display(length: "⏱ \(detail.runtimeStr!)")
            view.display(contentRating: "🔞 \(detail.contentRating!)")
            view.display(releaseDate: "🗓 \(detail.year!)")
            view.display(plot: detail.plot!)
        }
        
        if let image = cache.fetchImage(fromUrl: detail.image) {
            view.display(image: image)
        }
        else {
            downloadPoster(view: view)
        }
    }
    
    func downloadMovieDetail() {
        let url = resource.urlRequest.url
        
        if let movieDetail = cache.fetchMovie(forKey: url!.absoluteString) {
            self.movieDetail = movieDetail
            
            DispatchQueue.main.async {
                self.view.success()
            }
            return
        }
        
        networkService.execute(url: url!) { (result: Result<Movie?, Error>) in
            DispatchQueue.main.async {
                switch result {
                    case .success(let movieDetail):
                        self.movieDetail = movieDetail
                        self.cache.addMovie(movie: self.movieDetail!, forKey: url!.absoluteString)
                        self.view.success()
                    case .failure(let error):
                        print(error)
                }
            }
        }
    }
    
    private func downloadPoster(view: MovieDetailViewProtocol) {
        guard let detail = movieDetail else { return }
        
        networkService.downloadImage(url: detail.image) { (result: Result<UIImage?, Error>) in
            DispatchQueue.main.async {
                switch result {
                    case .success(let image):
                        self.cache.addImage(image: image!, fromUrl: detail.image)
                        view.display(image: image)
                    case.failure:
                        view.display(image: nil)
                }
            }
        }
    }
}
