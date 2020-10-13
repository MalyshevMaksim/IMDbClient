//
//  MovieCollectionType.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/17/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation

var APIKey = "k_09P3SOzm"

enum MovieEndpoint {
    case topRatedMovie, mostPopularMovie, topRatedTVShow, mostPopularTVShow, inTheater, comingSoon, search
    case detail(id: String), poster(id: String)
    
    private var baseUrl: URL { return URL(string: "https://imdb-api.com/en/API/")! }
    
    var resourceUrl: String {
        let beginningPath = baseUrl.absoluteURL.absoluteString
        
        switch self {
            case .topRatedMovie:
                return beginningPath + "Top250Movies/\(APIKey)"
            case .mostPopularMovie:
                return beginningPath + "MostPopularMovies/\(APIKey)"
            case .topRatedTVShow:
                return beginningPath + "Top250TVs/\(APIKey)"
            case .mostPopularTVShow:
                return beginningPath + "MostPopularTVs/\(APIKey)"
            case .inTheater:
                return beginningPath + "InTheaters/\(APIKey)"
            case .comingSoon:
                return beginningPath + "ComingSoon/\(APIKey)"
            case .detail(let id):
                return beginningPath + "Title/\(APIKey)/\(id)"
            case .poster(let imageUrl):
                return imageUrl
            case .search:
                return beginningPath + "SearchMovie/\(APIKey)/"
        }
    }
}
