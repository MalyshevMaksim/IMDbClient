//
//  File.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/2/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import UIKit

// The class responsible for navigating the application.
// For example, to show detailed information about a movie

class Router {
    var assembly: AssemblyBuilder
    var assemblyFactory: AssemblyFactory
    var rootNavigationController: UINavigationController
    
    init(assembly: AssemblyBuilder, assemblyFactory: AssemblyFactory, rootNavigationController: UINavigationController) {
        self.assembly = assembly
        self.assemblyFactory = assemblyFactory
        self.rootNavigationController = rootNavigationController
        initialNavigationController()
    }
    
    func initialNavigationController() {
        let mainViewController = assembly.makeMainViewController(assemblyFactory: assemblyFactory, navigationController: rootNavigationController, router: self)
        rootNavigationController.viewControllers = [mainViewController]
    }
    
    func showDetail(movieId: String) {
        let detailViewController = assembly.makeDetailViewController(movieId: movieId)
        rootNavigationController.pushViewController(detailViewController, animated: true)
    }
}
