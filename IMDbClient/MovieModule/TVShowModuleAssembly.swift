//
//  TVShowModuleAssembly.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/4/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

class TVShowModuleAssembly: MovieAssemblyBuilderProtocol {
    func makeMainViewController(navigationController: UINavigationController, router: Router) -> UIViewController {
        let view = MovieViewController()
        view.title = "TV series"
        let networkService = TVShowNetworkService()
        let presenter = MoviePresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
    func makeDetailViewController(movie: Movie) -> UIViewController {
        let view = DetailMovieController()
        let networkService = TVShowNetworkService()
        let presenter = DetailTopMoviePresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
}
