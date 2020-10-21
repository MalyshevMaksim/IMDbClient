//
//  MovieDownloaderFacade.swift
//  IMDbClientTests
//
//  Created by Малышев Максим Алексеевич on 10/16/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import XCTest
@testable import IMDbClient

class CacheGatewayMock: CacheGateway {
    var isImageCached = false
    var isMovieCollectionCached = false
    
    func addMovie(movie: Movie, forKey: String) {
        
    }
    
    func fetchMovie(forKey: String) -> Movie? {
        return nil
    }
    
    func addMovieCollection(forKey: String, collection: [Movie]) {
        isMovieCollectionCached = true
    }
    
    func fetchMovieCollection(forKey: String) -> [Movie]? {
        return nil
    }
    
    func addImage(image: UIImage, fromUrl: String) {
        isImageCached = true
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
    var cacheMock: CacheGatewayMock!
    
    var failureResourceStub = [APIRequestMock(state: .failure), APIRequestMock(state: .failure)]
    var successResourceStub = [APIRequestMock(state: .success), APIRequestMock(state: .success)]
    
    var successDataStub = try! JSONEncoder().encode(MovieList(items: [Movie(id: "foo", title: "bar", image: "baz")],
                                                              results: [Movie(id: "foo", title: "bar", image: "baz")],
                                                              errorMessage: ""))
    var successImageStub = UIImage(systemName: "folder.fill")!.pngData()
    
    override func setUp() {
        cacheMock = CacheGatewayMock()
        super.setUp()
    }
    
    override func tearDown() {
        APIRequestMock.numberOfRequests = 0
        cacheMock = nil
        sut = nil
        super.tearDown()
    }
    
    
    // MARK: DOWNLOAD TESTS
    
    func testAllResourceDownloadSuccess() {
        let networkServiceMock = NetworkServiceMock(dataStub: successDataStub)
        sut = MovieDownloaderFacade(requests: successResourceStub, networkService: networkServiceMock, cacheGateway: cacheMock)
        sut.download { error in }
        XCTAssertEqual(successResourceStub.count, APIRequestMock.numberOfRequests, "Not all requests completed")
    }
    
    func testResourceDownloadRequestFailure() {
        let networkService = NetworkServiceMock(dataStub: successDataStub)
        sut = MovieDownloaderFacade(requests: [APIRequestMock(state: .failure)], networkService: networkService, cacheGateway: cacheMock)
        let failureRequestExpectation = expectation(description: "Completion handler expectation")
        
        sut.download { error in
            XCTAssertNotNil(error, "Error was expected")
            failureRequestExpectation.fulfill()
        }
        wait(for: [failureRequestExpectation], timeout: 1)
    }
    
    func testDownloadResultSuccess() {
        let networkService = NetworkServiceMock(dataStub: successDataStub)
        sut = MovieDownloaderFacade(requests: [APIRequestMock(state: .success)], networkService: networkService, cacheGateway: cacheMock)
        let successResultExpectation = expectation(description: "Completion handler expectation")
        
        sut.download { error in
            XCTAssertNil(error, "Nil was expected")
            XCTAssertTrue(self.cacheMock.isMovieCollectionCached, "")
            successResultExpectation.fulfill()
        }
        wait(for: [successResultExpectation], timeout: 1)
    }
    
    func testDownloadResultFailure() {
        let networkServiceMock = NetworkServiceMock(dataStub: nil)
        sut = MovieDownloaderFacade(requests: [APIRequestMock(state: .success)], networkService: networkServiceMock, cacheGateway: cacheMock)
        let failureResultExpectation = expectation(description: "Completion handler expectation")
        
        sut.download { error in
            XCTAssertNotNil(error, "Error was expected")
            failureResultExpectation.fulfill()
        }
        wait(for: [failureResultExpectation], timeout: 1)
    }
    
    
    // MARK: DOWNLOAD POSTER TESTS
    
    func testDownloadPosterResultSuccess() {
        let networkServiceMock = NetworkServiceMock(dataStub: successImageStub)
        sut = MovieDownloaderFacade(requests: successResourceStub, networkService: networkServiceMock, cacheGateway: cacheMock)
        let successResultExpectation = expectation(description: "Completion handler expectation")
        
        sut.downloadPoster(posterUrl: URL.successUrl!.absoluteString) { image in
            XCTAssertNotNil(image, "Image was expected")
            successResultExpectation.fulfill()
        }
        wait(for: [successResultExpectation], timeout: 1)
        XCTAssertTrue(cacheMock.isImageCached, "Image is not cached")
    }
    
    func testDownloadPosterResultFailure() {
        let networkServiceMock = NetworkServiceMock(dataStub: nil)
        sut = MovieDownloaderFacade(requests: successResourceStub, networkService: networkServiceMock, cacheGateway: cacheMock)
        let failureResultExpectation = expectation(description: "Completion handler expectation")
        
        sut.downloadPoster(posterUrl: URL.successUrl!.absoluteString) { image in
            XCTAssertNil(image, "Nil was expedted")
            failureResultExpectation.fulfill()
        }
        wait(for: [failureResultExpectation], timeout: 1)
    }
    
    func testDownloadPosterComposedQueryFailure() {
        let networkService = NetworkServiceMock(dataStub: successDataStub)
        sut = MovieDownloaderFacade(requests: successResourceStub, networkService: networkService, cacheGateway: cacheMock)
        let failureResultExpectation = expectation(description: "Completion handler expectation")
        
        sut.downloadPoster(posterUrl: "") { image in
            XCTAssertNil(image, "Nil was expected")
            failureResultExpectation.fulfill()
        }
        wait(for: [failureResultExpectation], timeout: 1)
    }
    
    
    // MARK: SEARCH TESTS
    
    func testSearchResultSuccess() {
        let networkServiceMock = NetworkServiceMock(dataStub: successDataStub)
        sut = MovieDownloaderFacade(requests: successResourceStub, networkService: networkServiceMock, cacheGateway: cacheMock)
        let successResultExpectation = expectation(description: "Completion handler expectation")
        
        sut.search(searchText: "foo") { movies in
            XCTAssertNotNil(movies, "")
            successResultExpectation.fulfill()
        }
        wait(for: [successResultExpectation], timeout: 1)
    }
    
    func testSearchResultFailure() {
        let networkServiceMock = NetworkServiceMock(dataStub: nil)
        sut = MovieDownloaderFacade(requests: successResourceStub, networkService: networkServiceMock, cacheGateway: cacheMock)
        let failureResultExpectation = expectation(description: "Completion handler expectation")
        
        sut.search(searchText: "foo") { movies in
            XCTAssertNil(movies, "Nil was expected")
            failureResultExpectation.fulfill()
        }
        wait(for: [failureResultExpectation], timeout: 1)
    }
    
    func testComposedSearchQueryFailure() {
        let networkServiceMock = NetworkServiceMock(dataStub: successDataStub)
        sut = MovieDownloaderFacade(requests: failureResourceStub, networkService: networkServiceMock, cacheGateway: cacheMock)
        let failureComposedSearchQueryExpectation = expectation(description: "Completion handler expectation")
        
        sut.search(searchText: "") { movies in
            XCTAssertNil(movies, "Nil was expected")
            failureComposedSearchQueryExpectation.fulfill()
        }
        wait(for: [failureComposedSearchQueryExpectation], timeout: 1)
    }
    
    func testComposedSearchQueryCorrectly() {
        let networkServiceMock = NetworkServiceMock(dataStub: successDataStub)
        sut = MovieDownloaderFacade(requests: successResourceStub, networkService: networkServiceMock, cacheGateway: cacheMock)
        sut.search(searchText: "foo") { movie in }
        let sourceSearchRequest = successResourceStub.first!.urlRequest!.url!.absoluteString
        let resultSearchRequest = networkServiceMock.url.absoluteString
        XCTAssertEqual(resultSearchRequest, sourceSearchRequest + "foo", "Incorrectly formed search request")
    }
    
    func testTasksСanceledСorrectly() {
        let networkServiceMock = NetworkServiceMock(dataStub: successDataStub)
        sut = MovieDownloaderFacade(requests: successResourceStub, networkService: networkServiceMock, cacheGateway: cacheMock)
        sut.search(searchText: "foo") { movie in }
        XCTAssertEqual(networkServiceMock.isCancelCalled, true, "The cancellation method is not called")
        XCTAssertTrue(networkServiceMock.isCancelCalledBeforeExecute, "The cancellation method is called after execute")
    }
}
