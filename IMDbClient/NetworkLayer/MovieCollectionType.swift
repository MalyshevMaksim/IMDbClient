//
//  MovieCollectionType.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/17/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

var APIKey = "k_TqCmDS42"

enum MovieCollectionType {
    case topRatedMovie, mostPopularMovie, topRatedTVShow, mostPopularTVShow, inTheater, comingSoon, detail(id: String), poster(id: String)
    
    var resourceUrl: String {
        switch self {
            case .topRatedMovie: return "https://imdb-api.com/en/API/Top250Movies/\(APIKey)"
            case .mostPopularMovie: return "https://imdb-api.com/en/API/MostPopularMovies/\(APIKey)"
            case .topRatedTVShow: return "https://imdb-api.com/en/API/Top250TVs/\(APIKey)"
            case .mostPopularTVShow: return "https://imdb-api.com/en/API/MostPopularTVs/\(APIKey)"
            case .inTheater: return "https://imdb-api.com/en/API/InTheaters/\(APIKey)"
            case .comingSoon: return "https://imdb-api.com/en/API/ComingSoon/\(APIKey)"
            case .detail(let id): return "https://imdb-api.com/en/API/Title/\(APIKey)/\(id)"
            case .poster(let imageUrl): return imageUrl
        }
    }
}
