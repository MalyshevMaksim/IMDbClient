//
//  NewMovieAssembly.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/14/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

class NewMovieAssembly: AssemblyFactory {
    func makeMainViewController(navigationController: UINavigationController, router: Router) -> UIViewController {
        let view = NewMovieCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        view.title = "New Movies"
        let networkService = NewMovieNetworkService()
        let presenter = NewMoviePresenter(view: view, router: router, networkService: networkService)
        view.presenter = presenter
        return view
    }
    
    func makeDetailViewController(movieId: String) -> UIViewController {
        return UIViewController()
    }
}
