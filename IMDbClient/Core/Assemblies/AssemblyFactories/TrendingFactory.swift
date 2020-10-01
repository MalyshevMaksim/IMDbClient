//
//  TrendingFactory.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/21/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

class TrendingFactory: AssemblyFactory {
    func makeRequests() -> [APIRequest] {
        let topRatedRequest = GETMovieRequest(type: .inTheater)
        let mostPopularRequest = GETMovieRequest(type: .comingSoon)
        let resources = [topRatedRequest, mostPopularRequest]
        return resources
    }
    
    func makeViewController() -> ViewControllerProtocol {
        let view = MovieCollectionViewController(collectionViewLayout: generateLayout())
        view.title = "Trends"
        return view
    }
    
    func makeNetworkService() -> NetworkService {
        return APIClient(posterQuality: .normal)
    }
}
