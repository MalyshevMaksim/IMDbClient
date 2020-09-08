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
    var topRated: MovieList? { get set }
    var mostPopular: MovieList? { get set }
    var networkService: MovieNetworkServiceStrategy { get set }
    
    func tapOnTheMovie(from indexPath: IndexPath)
    func downloadTopRated()
    func downloadMostPopular()
}
