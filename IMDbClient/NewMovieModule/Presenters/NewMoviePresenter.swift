//
//  ComingPresenter.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/14/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation

protocol NewMoviePresenterProtocol {
    var comingSoonMovieCache: [NewMovieData]? { get set }
    var inTheatersMovieCache: [NewMovieData]? { get set }
    
    func downloadComingSoonMovie()
    func downloadInTheatersMovie()
}

class NewMoviePresenter: NewMoviePresenterProtocol {
    var comingSoonMovieCache: [NewMovieData]?
    var inTheatersMovieCache: [NewMovieData]?
    
    
    
    func downloadComingSoonMovie() {
        
    }
    
    func downloadInTheatersMovie() {
        
    }
}
