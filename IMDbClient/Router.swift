//
//  File.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/2/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

class Router {
    var assembly: AssemblyBuilderProtocol!
    var navigationController: UINavigationController!
    
    init(assembly: AssemblyBuilderProtocol, navigationController: UINavigationController) {
        self.assembly = assembly
        self.navigationController = navigationController
        initial()
    }
    
    func initial() {
        let mainViewController = assembly.makeMainViewController(navigationController: navigationController, router: self)
        navigationController.viewControllers = [mainViewController]
    }
    
    func showDetail(movieId: String) {
        let detailViewController = assembly.makeDetailViewController(movieId: movieId)
        navigationController.pushViewController(detailViewController, animated: true)
    }
}
