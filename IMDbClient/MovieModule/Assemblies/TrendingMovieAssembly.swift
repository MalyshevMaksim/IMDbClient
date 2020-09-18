//
//  NewMovieAssembly.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/14/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

class TrendingMovieAssembly: AssemblyBuilder {
    func makeMainViewController(navigationController: UINavigationController, router: Router) -> UIViewController {
        let view = NewMovieCollectionViewController()
        view.title = "Trending Movies"
       
        let topRatedRequest = DownloadMovieRequest(movieCollectionType: .inTheater)
        let mostPopularRequest = DownloadMovieRequest(movieCollectionType: .comingSoon)
        let resources = [topRatedRequest, mostPopularRequest]
        let networkService = NetworkServiceClient()
        
        let presenter = MoviePresenter(view: view, networkService: networkService, resources: resources, router: router)
        view.presenter = presenter
        return view
    }
    
    func makeDetailViewController(movieId: String) -> UIViewController {
        return UIViewController()
    }
}
