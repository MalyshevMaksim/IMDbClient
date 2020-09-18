//
//  MovieCollectionType.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/17/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation

enum MovieCollectionType {
    case topRatedMovie, mostPopularMovie, topRatedTVShow, mostPopularTVShow, inTheater, comingSoon
    
    var resourceUrl: String {
        switch self {
            case .topRatedMovie: return "https://imdb-api.com/en/API/Top250Movies/k_TqCmDS42"
            case .mostPopularMovie: return "https://imdb-api.com/en/API/MostPopularMovies/k_TqCmDS42"
            case .topRatedTVShow: return "https://imdb-api.com/en/API/Top250TVs/k_TqCmDS42"
            case .mostPopularTVShow: return "https://imdb-api.com/en/API/MostPopularTVs/k_TqCmDS42"
            case .inTheater: return "https://imdb-api.com/en/API/InTheaters/k_TqCmDS42"
            case .comingSoon: return "https://imdb-api.com/en/API/ComingSoon/k_TqCmDS42"
        }
    }
}
