//
//  AssemblyBuilderProtocol.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/4/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit


// Protocol responsible for building modules and installing dependencies between them

protocol MovieAssemblyBuilderProtocol {
    func makeMainViewController(navigationController: UINavigationController, router: Router) -> UIViewController
    func makeDetailViewController(movieId: String) -> UIViewController
}
