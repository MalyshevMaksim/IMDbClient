//
//  MovieCollectionType.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/17/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation

enum MovieEndpoint {
    case topRatedMovie, mostPopularMovie, topRatedTVShow, mostPopularTVShow, inTheater, comingSoon, search
    case detail(id: String), poster(id: String)
    
    private var apiKey: String { return AppDelegate.APIKey }
    private var baseUrl: URL { return URL(string: "https://imdb-api.com/en/API/")! }
    
    var resourceUrl: String {
        let beginningPath = baseUrl.absoluteURL.absoluteString
        
        switch self {
            case .topRatedMovie:
                return beginningPath + "Top250Movies/\(apiKey)"
            case .mostPopularMovie:
                return beginningPath + "MostPopularMovies/\(apiKey)"
            case .topRatedTVShow:
                return beginningPath + "Top250TVs/\(apiKey)"
            case .mostPopularTVShow:
                return beginningPath + "MostPopularTVs/\(apiKey)"
            case .inTheater:
                return beginningPath + "InTheaters/\(apiKey)"
            case .comingSoon:
                return beginningPath + "ComingSoon/\(apiKey)"
            case .detail(let id):
                return beginningPath + "Title/\(apiKey)/\(id)"
            case .poster(let imageUrl):
                return imageUrl
            case .search:
                return beginningPath + "SearchMovie/\(apiKey)/"
        }
    }
}
