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
    
    var isCancelCalled = false
    var isCancelCalledBeforeExecute = false
    var url: URL!
    
    func execute<T>(url: URL, comletionHandler: @escaping (Result<T?, Error>) -> ()) where T : Decodable {
        self.url = url
        isCancelCalledBeforeExecute = isCancelCalled ? true : false
    }
    
    func downloadImage(url: URL, completionHandler: @escaping (Result<UIImage?, Error>) -> ()) {
        
    }
    
    func cancelAllTasks() {
        isCancelCalled = true
    }
}

class APIRequestMock: APIRequest {
    static var numberOfRequests = 0
    
    var urlRequest: URLRequest {
        APIRequestMock.numberOfRequests += 1
        return URLRequest(url: URL(string: "foo")!)
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
    var sut: MovieDownloaderFacade!
    var networkServiceMock: NetworkServiceMock!
    var cacheMock: CacheGatewayMock!
    var resourceStub = [APIRequestMock(), APIRequestMock(), APIRequestMock()]
    
    override func setUp() {
        networkServiceMock = NetworkServiceMock()
        cacheMock = CacheGatewayMock()
        sut = MovieDownloaderFacade(requests: resourceStub, networkService: networkServiceMock, cacheGateway: cacheMock)
        super.setUp()
    }
    
    override func tearDown() {
        APIRequestMock.numberOfRequests = 0
        networkServiceMock = nil
        cacheMock = nil
        sut = nil
        super.tearDown()
    }
    
    func testAllResourceDownload() {
        sut.download { error in }
        XCTAssertEqual(resourceStub.count, APIRequestMock.numberOfRequests, "Not all requests completed")
    }
    
    func testSearchRequest() {
        let searchText = "foo"
        sut.search(searchText: searchText) { movie in }
        
        let sourceSearchRequest = resourceStub.first!.urlRequest.url!.absoluteString
        let resultSearchRequest = networkServiceMock.url.absoluteString
        
        XCTAssertEqual(resultSearchRequest, sourceSearchRequest + searchText, "Incorrectly formed search request")
        XCTAssertEqual(networkServiceMock.isCancelCalled, true, "The cancellation method is not called")
        XCTAssertEqual(networkServiceMock.isCancelCalledBeforeExecute, true, "The cancellation method is called after execute")
    }
}
