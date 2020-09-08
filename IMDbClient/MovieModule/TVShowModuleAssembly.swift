//
//  TVShowModuleAssembly.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/4/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

class TVShowModuleAssembly: MovieAssemblyBuilderStrategy {
    func makeMainViewController(navigationController: UINavigationController, router: Router) -> UIViewController {
        let view = MovieViewController()
        view.title = "TV series"
        let networkService = TVShowNetworkService()
        let presenter = MoviePresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
    func makeDetailViewController(movieId: String) -> UIViewController {
        let view = DetailMovieViewController()
        let presenter = DetailMoviePresenter(view: view, movieId: movieId)
        presenter.downloadDetailMovie(with: movieId)
        view.presenter = presenter
        return view
    }
}
