//
//  MovieDownloaderFacade.swift
//  IMDbClientTests
//
//  Created by Малышев Максим Алексеевич on 10/16/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import XCTest
@testable import IMDbClient

class NetworkServiceMock: NetworkService {
    var quality: PosterEndpoint = .low
    var isCancelAllTasksCalled = false
    
    func execute<T>(url: URL, comletionHandler: @escaping (Result<T?, Error>) -> ()) where T : Decodable {
        
    }
    
    func downloadImage(url: URL, completionHandler: @escaping (Result<UIImage?, Error>) -> ()) {
        
    }
    
    func cancelAllTasks() {
        isCancelAllTasksCalled = true
    }
}

class CacheGatewayMock: CacheGateway {
    func addMovie(movie: Movie, forKey: String) {
        
    }
    
    func fetchMovie(forKey: String) -> Movie? {
        return nil
    }
    
    func addMovieCollection(forKey: String, collection: [Movie]) {
        
    }
    
    func fetchMovieCollection(forKey: String) -> [Movie]? {
        return nil
    }
    
    func addImage(image: UIImage, fromUrl: String) {
        
    }
    
    func fetchImage(fromUrl: String) -> UIImage? {
        return nil
    }
    
    func getCountOfMovies() -> Int {
        return 0
    }
    
    func getCountOfCollections() -> Int {
        return 0
    }
}

class MovieDownloaderFacadeTest: XCTestCase {
    var networkServiceMock = NetworkServiceMock()
    var cacheMock = CacheGatewayMock()
    var resourceStub = GETMovieRequest(endpoint: .topRatedMovie)
    var stub: Movie
    
    override func setUp() {
       
        super.setUp()
    }
    
    override func tearDown() {
        stub = nil
        super.tearDown()
    }
    
    func testSearchCalledAllTasksCancel() {
    }
}
