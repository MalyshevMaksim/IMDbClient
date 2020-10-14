//
//  SearchFactory.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 10/1/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation

class SearchFactory: AssemblyFactory {
    func makePresenter(view: ViewControllerProtocol, downloader: MovieDownloaderFacade, router: Router) -> MoviePresenterProtocol {
        return MovieSearchPresenter(view: view, movieDownloader: downloader, router: router)
    }
    
    func makeRequests() -> [APIRequest] {
        let searchRequest = GETMovieRequest(endpoint: .search)
        return [searchRequest]
    }
    
    func makeViewController() -> ViewControllerProtocol {
        let viewController = SearchViewController()
        viewController.title = "Search"
        return viewController
    }
    
    func makeNetworkService() -> NetworkService {
        return APIService(quality: .low)
    }
}
