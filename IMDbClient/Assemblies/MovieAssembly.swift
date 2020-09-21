//
//  AssemblyBuilder.swift
//  IMDbAPI
//
//  Created by Малышев Максим Алексеевич on 9/2/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import UIKit

// Protocol responsible for building modules and installing dependencies between them.
// Assembly builders create the necessary resources based on the factory method, which
// allows you to avoid duplicating the code of presenters.

protocol AssemblyBuilder {
    func makeMainViewController(assemblyFactory: AssemblyFactory, navigationController: UINavigationController, router: Router) -> UIViewController
    func makeDetailViewController(movieId: String) -> UIViewController
}

class MovieAssembly: AssemblyBuilder {
    func makeMainViewController(assemblyFactory: AssemblyFactory, navigationController: UINavigationController, router: Router) -> UIViewController {
        let view = assemblyFactory.makeViewController()
        let resources = assemblyFactory.makeResources()
        let networkService = assemblyFactory.makeNetworkService()
        
        let presenter = MoviePresenter(view: view, networkService: networkService, resources: resources, router: router)
        view.presenter = presenter
        return view
    }
    
    func makeDetailViewController(movieId: String) -> UIViewController {
        let view = MovieDetailViewController()
        let presenter = MovieDetailPresenter(view: view, movieId: movieId)
        view.presenter2 = presenter
        return view
    }
}
