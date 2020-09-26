//
//  TVShowFactory.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/21/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation

class TVShowFactory: AssemblyFactory {
    func makeResources() -> [DownloadMovieRequest] {
        let topRatedRequest = DownloadMovieRequest(movieCollectionType: .topRatedTVShow)
        let mostPopularRequest = DownloadMovieRequest(movieCollectionType: .mostPopularTVShow)
        let resources = [topRatedRequest, mostPopularRequest]
        return resources
    }
    
    func makeViewController() -> ViewControllerProtocol {
        let view = MovieTableViewController()
        view.title = "TV series"
        return view
    }
    
    func makeNetworkService() -> NetworkClient {
        return APIClient(posterQuality: .low)
    }
}
