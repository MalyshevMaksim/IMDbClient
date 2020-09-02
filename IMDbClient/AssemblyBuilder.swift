//
//  AssemblyBuilder.swift
//  IMDbAPI
//
//  Created by Малышев Максим Алексеевич on 9/2/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

class AssemblyBuilder {
    func makeTopMovieController() -> UIViewController {
        let view = TopMovieViewController()
        let networkService = NetworkService()
        let presenter = TopMoviePresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
}
