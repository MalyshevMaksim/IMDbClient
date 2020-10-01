//
//  TVShowFactory.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/21/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation

class TVShowFactory: AssemblyFactory {
    func makeRequests() -> [APIRequest] {
        let topRatedRequest = GETMovieRequest(type: .topRatedTVShow)
        let mostPopularRequest = GETMovieRequest(type: .mostPopularTVShow)
        let resources = [topRatedRequest, mostPopularRequest]
        return resources
    }
    
    func makeViewController() -> ViewControllerProtocol {
        let view = MovieTableViewController()
        view.title = "TV series"
        return view
    }
    
    func makeNetworkService() -> NetworkService {
        return APIClient(posterQuality: .low)
    }
}
