//
//  AssemblyBuilder.swift
//  IMDbAPI
//
//  Created by Малышев Максим Алексеевич on 9/2/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

class MovieModuleAssembly: MovieAssemblyBuilderProtocol {
    func makeMainViewController(navigationController: UINavigationController, router: Router) -> UIViewController {
        let view = MovieViewController()
        view.title = "Movies"
        let networkService = MovieNetworkService()
        let presenter = MoviePresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
    func makeDetailViewController(movieId: String) -> UIViewController {
        let view = DetailMovieViewController()
        let presenter = DetailMoviePresenter(view: view, movieId: movieId)
        view.presenter = presenter
        return view
    }
}
