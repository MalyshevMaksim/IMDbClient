//
//  File.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 10/23/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

class MovieDownloaderFacadeStub: MovieDownloaderFacadeProtocol {
    var successStub = false
    var isGetCountOfMoviesCalled = false
    var isGetCachedMovieCalled = false
    
    func download(completion: @escaping (Error?) -> ()) {
        completion(successStub ? nil : NSError.makeError(withMessage: "foo"))
    }
    
    func downloadPoster(posterUrl: String, completion: @escaping (UIImage?) -> ()) {
        completion(successStub ? nil : UIImage(systemName: "folder.fill"))
    }
    
    func search(searchText: String, completion: @escaping ([Movie]?) -> ()) {
        completion(successStub ? nil : [])
    }
    
    func getCachedMovie(fromSection: Int, forRow: Int) -> Movie? {
        isGetCachedMovieCalled = true
        return nil
    }
    
    func getCachedMovies(fromSection: Int) -> [Movie]? {
        return nil
    }
    
    func getCachedImage(for key: String) -> UIImage? {
        return nil
    }
    
    func getNumberOfSection() -> Int {
        return 0
    }
    
    func getCountOfMovies(fromSection: Int) -> Int {
        isGetCountOfMoviesCalled = true
        return 0
    }
}
