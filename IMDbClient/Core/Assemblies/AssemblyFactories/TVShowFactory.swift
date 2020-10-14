//
//  TVShowFactory.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/21/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation

class TVShowFactory: AssemblyFactory {
    func makePresenter(view: ViewControllerProtocol, downloader: MovieDownloaderFacade, router: Router) -> MoviePresenterProtocol {
        return MoviePresenter(view: view, movieDownloader: downloader, router: router)
    }
    
    func makeRequests() -> [APIRequest] {
        let topRatedRequest = GETMovieRequest(endpoint: .topRatedTVShow)
        let mostPopularRequest = GETMovieRequest(endpoint: .mostPopularTVShow)
        return [topRatedRequest, mostPopularRequest]
    }
    
    func makeViewController() -> ViewControllerProtocol {
        let view = MovieTableViewController()
        view.title = "TV series"
        return view
    }
    
    func makeNetworkService() -> NetworkService {
        return APIService(quality: .low)
    }
}
