//
//  ComingPresenter.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/14/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

protocol NewMoviePresenterProtocol {
    var comingSoonMovieCache: NewMovieData? { get set }
    var inTheatersMovieCache: NewMovieData? { get set }
    
    func downloadMovies(collectionType: NewMovieCollectionType)
    func getCountOfMovies(section: Int) -> Int
    func displayCell(cell: NewMovieCell, section: Int, forRow row: Int)
}

class NewMoviePresenter: NewMoviePresenterProtocol {
    var view: ViewControllerProtocol
    var router: Router
    var networkService: NewMovieNetworkStrategy
    
    var imageCache = NSCache<NSString, UIImage>()
    var comingSoonMovieCache: NewMovieData?
    var inTheatersMovieCache: NewMovieData?
    
    init(view: ViewControllerProtocol, router: Router, networkService: NewMovieNetworkStrategy) {
        self.view = view
        self.router = router
        self.networkService = networkService
        downloadMovies()
    }
    
    func downloadMovies(collectionType: NewMovieCollectionType = .inTheaters) {
        networkService.downloadMovies(collectionType: collectionType) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                    case .success(let movies):
                        switch collectionType {
                            case .inTheaters:
                                self.inTheatersMovieCache = movies
                                self.downloadMovies(collectionType: .inTheaters)
                            case .comingSoon:
                                self.comingSoonMovieCache = movies
                                self.view.success()
                    }
                    case .failure(let error):
                        self.view.failure(error: error)
                }
            }
        }
    }
    
    private func getCachedMovie(section: Int, for row: Int) -> NewMovie? {
        switch section {
            case 0:
                return inTheatersMovieCache?.items[row]
            default:
                return comingSoonMovieCache?.items[row]
        }
    }
    
    func displayCell(cell: NewMovieCell, section: Int, forRow row: Int) {
        guard let movie = getCachedMovie(section: section, for: row) else {
            return
        }
        cell.display(title: movie.title)
        cell.display(runtimeStr: "⏱ \(movie.runtimeStr)")
        
        if let poster = imageCache.object(forKey: movie.image as NSString) {
            cell.display(image: poster)
        }
        else {
            downloadImage(cell: cell, from: movie.image)
        }
    }
    
    func getCountOfMovies(section: Int) -> Int {
        switch section {
            case 0:
                return inTheatersMovieCache?.items.count ?? 0
            default:
                return comingSoonMovieCache?.items.count ?? 0
        }
    }
    
    // Uploading an image and adding it to the cache
    private func downloadImage(cell: NewMovieCell, from url: String) {
        cell.display(image: nil)
        guard let url = URL(string: url) else { fatalError("Error") }
        cell.startActivity()
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async {
                cell.display(image: image)
                cell.stopActivity()
                self.imageCache.setObject(image, forKey: (url.absoluteString as NSString))
            }
        }.resume()
    }
}
