//
//  AssemblyFactory.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/18/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import UIKit

// A factory that is responsible for creating resources for the presenter to load.
// In case of adding new resources to the system, it is enough to expand this interface.
// Thus, we close the presenter for change, but open it for extension.
// In addition, this will allow us to avoid duplicating the code of the Assembly builders

protocol AssemblyFactory {
    func makeResources() -> [DownloadMovieRequest]
    func makeViewController() -> ViewControllerProtocol
    func makeNetworkService() -> NetworkService
}

class MovieFactory: AssemblyFactory {
    func makeResources() -> [DownloadMovieRequest] {
        let topRatedRequest = DownloadMovieRequest(movieCollectionType: .topRatedMovie)
        let mostPopularRequest = DownloadMovieRequest(movieCollectionType: .mostPopularMovie)
        let resources = [topRatedRequest, mostPopularRequest]
        return resources
    }
    
    func makeViewController() -> ViewControllerProtocol {
        let view = MovieTableViewController()
        view.title = "Movies"
        return view
    }
    
    func makeNetworkService() -> NetworkService {
        return NetworkServiceClient(posterQuality: .low)
    }
}

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
    
    func makeNetworkService() -> NetworkService {
        return NetworkServiceClient(posterQuality: .low)
    }
}

class TrendingFactory: AssemblyFactory {
    func makeResources() -> [DownloadMovieRequest] {
        let topRatedRequest = DownloadMovieRequest(movieCollectionType: .inTheater)
        let mostPopularRequest = DownloadMovieRequest(movieCollectionType: .comingSoon)
        let resources = [topRatedRequest, mostPopularRequest]
        return resources
    }
    
    func makeViewController() -> ViewControllerProtocol {
        let view = MovieCollectionViewController()
        view.title = "Trends"
        return view
    }
    
    func makeNetworkService() -> NetworkService {
        return NetworkServiceClient(posterQuality: .square)
    }
}
