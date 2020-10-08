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
    func makePresenter(router: Router, downloader: MovieDownloaderFacade) -> MoviePresenterProtocol {
        return MoviePresenter(view: makeViewController(), resourceDownloader: downloader, router: router)
    }
    
    func makeRequests() -> [APIRequest] {
        let topRatedRequest = GETMovieRequest(endpoint: .inTheater)
        let mostPopularRequest = GETMovieRequest(endpoint: .comingSoon)
        let resources = [topRatedRequest, mostPopularRequest]
        return resources
    }
    
    func makeViewController() -> ViewControllerProtocol {
        let view = MovieCollectionViewController(collectionViewLayout: generateLayout())
        view.title = "Trends"
        return view
    }
    
    func makeNetworkService() -> NetworkService {
        return APIService(quality: .normal)
    }
}
