//
//  DetailTopMoviePresenter.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/2/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

class DetailTopMoviePresenter: MoviePresenterProtocol {
    func loadTopRatedMovies() {
        
    }
    
    func loadMostPopularMovies() {
        
    }
    
    func getTopRatedMovies() {
        
    }
    
    func getMostPopularMovies() {
        
    }
    
    var topRatedMovies: [Movie]?
    
    var mostPopularMovies: [Movie]?
    
    var networkService: NetworkServiceProtocol
    
    var movies: [Movie]?
    
    func tapOnTheMovie(from indexPath: IndexPath) {
        
    }
    
    func getMovies() {
        
    }
    
    var view: ViewControllerProtocol
    var router: Router?
    
    func showModel() {
           
    }
       
    func showDetailModel(from indexPath: IndexPath) {
       
    }
   
   func getCountOfModel() -> Int {
       return 0
   }
    
    init(view: ViewControllerProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
    }
}
