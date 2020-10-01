//
//  SearchFactory.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 10/1/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation

class SearchFactory: AssemblyFactory {
    func makeRequests() -> [APIRequest] {
        let searchRequest = GETMovieRequest(type: .search)
        return [searchRequest]
    }
    
    func makeViewController() -> ViewControllerProtocol {
        let viewController = SearchViewController()
        viewController.title = "Search"
        return viewController
    }
    
    func makeNetworkService() -> NetworkService {
        return APIService(posterQuality: .low)
    }
}
