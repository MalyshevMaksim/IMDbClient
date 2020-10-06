//
//  MovieFactory.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/21/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation

class MovieFactory: AssemblyFactory {
    func makeRequests() -> [APIRequest] {
        let topRatedRequest = GETMovieRequest(endpoint: .topRatedMovie)
        let mostPopularRequest = GETMovieRequest(endpoint: .mostPopularMovie)
        let resources = [topRatedRequest, mostPopularRequest]
        return resources
    }
    
    func makeViewController() -> ViewControllerProtocol {
        let view = MovieTableViewController()
        view.title = "Movies"
        return view
    }
    
    func makeNetworkService() -> NetworkService {
        return APIService(posterEndpoint: .lowQuality)
    }
}
