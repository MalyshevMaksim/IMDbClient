//
//  DetailMoviePresenterProtocol.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/7/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation

protocol DetailMoviePresenterProtocol {
    var detailMovie: DetailMovie! { get set }
    func downloadDetailMovie(with movieId: String)
}
