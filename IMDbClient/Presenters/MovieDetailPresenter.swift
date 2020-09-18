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
    var movieId: String { get set }
    func downloadMovieDetail(withId id: String)
    func configureView(view: MovieDetailView)
}

class MovieDetailPresenter: MovieDetailPresenterProtocol {
    var view: ViewControllerProtocol
    var movieId: String
    var movieDetail: MovieDetail!
    
    init(view: ViewControllerProtocol, movieId: String) {
        self.movieId = movieId
        self.view = view
        downloadMovieDetail(withId: movieId)
    }
    
    func configureView(view: MovieDetailView) {
        view.display(title: movieDetail.title)
        view.display(imDbRating: movieDetail.imDbRating)
        view.display(length: "⏱ \(movieDetail.imDbRating)")
        view.display(contentRating: "🔞 \(movieDetail.contentRating)")
        view.display(releaseDate: "🗓 \(movieDetail.releaseDate)")
        view.display(plot: movieDetail.plot)
    }
    
    func downloadMovieDetail(withId id: String) {
        URLSession.shared.dataTask(with: URL(string: "https://imdb-api.com/en/API/Title/\(APIKey)/\(movieId)")!) { data, response, error in
            do {
                let jsonData = try JSONDecoder().decode(MovieDetail.self, from: data!)
                self.movieDetail = jsonData
                
                DispatchQueue.main.async {
                    self.view.success()
                }
            }
            catch {
                print(error)
            }
        }.resume()
    }
}
