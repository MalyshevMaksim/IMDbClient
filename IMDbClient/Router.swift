//
//  File.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/2/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit


/* The class responsible for navigating the application. For example, if the user selects a cell in the table,
   then the responsibility for creating and displaying the detailed view passes to the router. As a property,
   it has a link to the assembly builder to determine which module is being navigated through */

class Router {
    var assembly: MovieAssemblyBuilderProtocol
    var rootNavigationController: UINavigationController
    
    init(assembly: MovieAssemblyBuilderProtocol, rootNavigationController: UINavigationController) {
        self.assembly = assembly
        self.rootNavigationController = rootNavigationController
        initialNavigationController()
    }
    
    func initialNavigationController() {
        let mainViewController = assembly.makeMainViewController(navigationController: rootNavigationController, router: self)
        rootNavigationController.viewControllers = [mainViewController]
    }
    
    func showDetail(movieId: String) {
        let detailViewController = assembly.makeDetailViewController(movieId: movieId)
        rootNavigationController.pushViewController(detailViewController, animated: true)
    }
}
