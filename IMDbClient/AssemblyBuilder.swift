//
//  AssemblyBuilder.swift
//  IMDbAPI
//
//  Created by Малышев Максим Алексеевич on 9/2/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

protocol MovieViewProtocol {
    func success()
    func failure(error: Error)
}

protocol AssemblyBuilderProtocol {
    func makeMainViewController(navigationController: UINavigationController, router: Router) -> UIViewController
    func makeDetailViewController(movieId: String) -> UIViewController
}

class TopMovieAssembly: AssemblyBuilderProtocol {
    func makeMainViewController(navigationController: UINavigationController, router: Router) -> UIViewController {
        let view = TopMovieViewController()
        let networkService = NetworkService()
        let presenter = TopMoviePresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
    func makeDetailViewController(movieId: String) -> UIViewController {
        let view = DetailTopMovieController()
        let networkService = NetworkService()
        let presenter = DetailTopMoviePresenter(view: view, movieId: movieId, networkService: networkService)
        view.presenter = presenter
        return view
    }
}
