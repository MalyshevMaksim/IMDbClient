//
//  MovieFactory.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/21/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

class MovieFactory: AssemblyFactory {
    func makePresenter(view: ViewControllerProtocol, downloader: MovieDownloaderFacade, router: Router) -> MoviePresenterProtocol {
        return MoviePresenter(view: view, movieDownloader: downloader, router: router)
    }
    
    func makeRequests() -> [APIRequest] {
        let topRatedRequest = GETMovieRequest(endpoint: .topRatedMovie)
        let mostPopularRequest = GETMovieRequest(endpoint: .mostPopularMovie)
        return [topRatedRequest, mostPopularRequest]
    }
    
    func makeViewController() -> ViewControllerProtocol {
        let view = MovieTableViewController()
        view.title = "Movies"
        return view
    }
    
    func makeNetworkService() -> NetworkService {
        return APIService(quality: PosterQualityEndpoint(quality: .low))
    }
}
