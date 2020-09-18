//
//  AssemblyBuilder.swift
//  IMDbAPI
//
//  Created by Малышев Максим Алексеевич on 9/2/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

class MovieAssembly: AssemblyBuilder {
    func makeMainViewController(navigationController: UINavigationController, router: Router) -> UIViewController {
        let view = MovieTableViewController()
        view.title = "Movies"
        
        let topRatedRequest = DownloadMovieRequest(movieCollectionType: .topRatedMovie)
        let mostPopularRequest = DownloadMovieRequest(movieCollectionType: .mostPopularMovie)
        let resources = [topRatedRequest, mostPopularRequest]
        let networkService = NetworkServiceClient()
        
        let presenter = MoviePresenter(view: view, networkService: networkService, resources: resources, router: router)
        view.presenter = presenter
        return view
    }
    
    func makeDetailViewController(movieId: String) -> UIViewController {
        let view = MovieDetailViewController()
        let presenter = MovieDetailPresenter(view: view, movieId: movieId)
        view.presenter = presenter
        return view
    }
}
