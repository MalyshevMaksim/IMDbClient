//
//  AssemblyBuilder.swift
//  IMDbAPI
//
//  Created by Малышев Максим Алексеевич on 9/2/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import UIKit

// Protocol responsible for building modules and installing dependencies between them
// Assembly builders create the necessary resources based on the factory method, which
// allows you to avoid duplicating the code of presenters

protocol AssemblyBuilder {
    func makeMainViewController(assemblyFactory: AssemblyFactory, navigationController: UINavigationController, router: RouterProtocol) -> UIViewController
    func makeDetailViewController(movieId: String) -> UIViewController
}

class MovieAssembly: AssemblyBuilder {
    // Each presenter has its own copy of the cache,
    // but there must be a single cache for all detailed information about the movies
    private static var detailMovieCache = InMemoryCache()
    
    func makeMainViewController(assemblyFactory: AssemblyFactory, navigationController: UINavigationController, router: RouterProtocol) -> UIViewController {
        let view = assemblyFactory.makeViewController()
        let resources = assemblyFactory.makeRequests()
        let networkService = assemblyFactory.makeNetworkService()
        
        let movieDownloader = MovieDownloaderFacade(requests: resources, networkService: networkService, cacheGateway: InMemoryCache())
        let presenter: MoviePresenterProtocol = assemblyFactory.makePresenter(view: view, downloader: movieDownloader, router: router)

        view.presenter = presenter
        return view
    }
    
    func makeDetailViewController(movieId: String) -> UIViewController {
        let view = MovieDetailViewController()
        let networkService = APIService(quality: PosterQualityEndpoint(quality: .normal))
        let resource = GETMovieRequest(endpoint: .detail(id: movieId))
        
        let presenter = MovieDetailPresenter(view: view, networkService: networkService, resource: resource, cache: MovieAssembly.detailMovieCache)
        view.presenter = presenter
        return view
    }
}
