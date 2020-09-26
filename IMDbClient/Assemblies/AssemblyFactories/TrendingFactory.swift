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
    func makeResources() -> [DownloadMovieRequest] {
        let topRatedRequest = DownloadMovieRequest(movieCollectionType: .inTheater)
        let mostPopularRequest = DownloadMovieRequest(movieCollectionType: .comingSoon)
        let resources = [topRatedRequest, mostPopularRequest]
        return resources
    }
    
    func makeViewController() -> ViewControllerProtocol {
        let view = MovieCollectionViewController(collectionViewLayout: generateLayout())
        view.title = "Trends"
        return view
    }
    
    func makeNetworkService() -> NetworkClient {
        return APIClient(posterQuality: .normal)
    }
}
