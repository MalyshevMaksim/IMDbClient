//
//  DetailTopMoviePresenter.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/2/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

class DetailMoviePresenter: DetailMoviePresenterProtocol {
    var view: ViewControllerProtocol
    var detailMovie: DetailMovie!
    var movieId: String
    
    func downloadDetailMovie(with movieId: String) {
        URLSession.shared.dataTask(with: URL(string: "https://imdb-api.com/en/API/Title/k_7k80gZKE/\(movieId)")!) { data, response, error in
            do {
                let jsonData = try JSONDecoder().decode(DetailMovie.self, from: data!)
                self.detailMovie = jsonData
                
                DispatchQueue.main.async {
                    self.view.success()
                }
            }
            catch {
                print(error)
            }
        }
        .resume()
    }
    
    init(view: ViewControllerProtocol, movieId: String) {
        self.movieId = movieId
        self.view = view
        downloadDetailMovie(with: movieId)
    }
}
