//
//  MovieFactory.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/21/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation

class MovieFactory: AssemblyFactory {
    func makeResources() -> [GETMovieRequest] {
        let topRatedRequest = GETMovieRequest(type: .topRatedMovie)
        let mostPopularRequest = GETMovieRequest(type: .mostPopularMovie)
        let resources = [topRatedRequest, mostPopularRequest]
        return resources
    }
    
    func makeViewController() -> ViewControllerProtocol {
        let view = MovieTableViewController()
        view.title = "Movies"
        return view
    }
    
    func makeNetworkService() -> NetworkClient {
        return APIClient(posterQuality: .low)
    }
}
