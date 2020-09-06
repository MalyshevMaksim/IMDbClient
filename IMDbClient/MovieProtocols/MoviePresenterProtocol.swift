//
//  PresenterProtocol.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/4/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

protocol MoviePresenterProtocol {
    var topRatedMovies: [Movie]? { get set }
    var mostPopularMovies: [Movie]? { get set }
    var networkService: MovieNetworkServiceProtocol { get set }
    
    func tapOnTheMovie(from indexPath: IndexPath)
    func loadTopRatedMovies()
    func loadMostPopularMovies()
}
