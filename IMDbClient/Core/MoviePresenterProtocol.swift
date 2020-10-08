//
//  MoviePresenterProtocol.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 10/5/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

protocol MoviePresenterProtocol {
    var resourceDownloader: MovieDownloaderFacade { get }
    var view: ViewControllerProtocol { get }
    var delegate: FilterMovieDelegate { get set }
    var router: Router { get }
    
    func displayCell(cell: MovieCellProtocol, in section: Int, for row: Int)
    func showDetail(fromSection: Int, forRow: Int)
    func getCountOfMovies(section: Int) -> Int
    func downloadMovies()
}

protocol FilterMovieDelegate {
    func filter(_ searchController: UISearchController, didChangeSearchText text: String, in section: Int)
}
