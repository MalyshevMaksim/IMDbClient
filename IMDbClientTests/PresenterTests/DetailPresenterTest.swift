//
//  DetailPresenterTest.swift
//  IMDbClientTests
//
//  Created by Малышев Максим Алексеевич on 10/23/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import XCTest
@testable import IMDbClient

class DetailStubViewController: UIViewController, DetailViewControllerProtocol {
    var presenter: MovieDetailPresenterProtocol!
    var isSuccessCalled = false
    var isFailureCalled = false
    
    func success() {
        isSuccessCalled = true
    }
    
    func failure(error: Error) {
        isFailureCalled = true
    }
}

class DetailViewStub: UIViewController, MovieDetailViewProtocol {
    var image: UIImage?
    var movieTitle: String?
    var imDbRating: String?
    var length: String?
    var releaseDate: String?
    var contentRating: String?
    var plot: String?
    
    func display(image: UIImage?) {
        self.image = image
    }
    
    func display(title: String) {
        self.movieTitle = title
    }
    
    func display(imDbRating: String) {
        self.imDbRating = imDbRating
    }
    
    func display(length: String) {
        self.length = length
    }
    
    func display(releaseDate: String) {
        self.releaseDate = releaseDate
    }
    
    func display(contentRating: String) {
        self.contentRating = contentRating
    }
    
    func display(plot: String) {
        self.plot = plot
    }
}

class DetailPresenterTest: XCTestCase {
    var viewStub: DetailStubViewController!
    var networkMock: NetworkServiceMock!
    var requestStub: APIRequest!
    var cacheStub: CacheGatewayStub!
    var sut: MovieDetailPresenter!

    override func setUp() {
        super.setUp()
        viewStub = DetailStubViewController()
        networkMock = NetworkServiceMock(dataStub: nil)
        cacheStub = CacheGatewayStub()
        requestStub = APIRequestMock(state: .success)
        sut = MovieDetailPresenter(view: viewStub, networkService: networkMock, resource: requestStub, cache: cacheStub)
    }
    
    override func tearDown() {
        super.tearDown()
        viewStub = nil
        networkMock = nil
        cacheStub = nil
        requestStub = nil
        sut = nil
    }
    
    func testConfigureView() {
        let movieStub = Movie(id: "foo", title: "foo", image: "foo", crew: "foo", plot: "foo", description: "foo", imDbRating: "foo", imDbRatingCount: "foo", runtimeStr: "foo", year: "foo", releaseDate: "foo", contentRating: "foo")
        let view = DetailViewStub()
        sut.movieDetail = movieStub
        sut.configureView(view: view)
        
        XCTAssertEqual(movieStub.title, view.movieTitle)
        XCTAssertEqual(movieStub.imDbRating, view.imDbRating)
        XCTAssertEqual(movieStub.runtimeStr, view.length)
        XCTAssertEqual(movieStub.releaseDate, view.releaseDate)
        XCTAssertEqual(movieStub.plot, view.plot)
        XCTAssertEqual(movieStub.contentRating, view.contentRating)
    }
    
    func testDownloaDetailExecuteSuccess() {
        let movieStub = Movie(id: "1", title: "foo", image: "bar", crew: "baz")
        networkMock.dataStub = try! JSONEncoder().encode(movieStub)
        sut.downloadMovieDetail()
        XCTAssertTrue(viewStub.isSuccessCalled)
        XCTAssertTrue(cacheStub.isMovieCached)
        XCTAssertEqual(sut.movieDetail, movieStub)
    }
    
    func testDownloaDetailExecuteFailure() {
        networkMock.dataStub = nil
        sut.downloadMovieDetail()
        XCTAssertTrue(viewStub.isFailureCalled)
        XCTAssertNil(sut.movieDetail)
    }
    
    func testDownloaDetailExecuteRequestFail() {
        let failureResourceStub = APIRequestMock(state: .failure)
        sut.resource = failureResourceStub
        viewStub.isFailureCalled = false
        sut.downloadMovieDetail()
        
        XCTAssertNil(sut.movieDetail)
        XCTAssertFalse(viewStub.isFailureCalled)
        XCTAssertFalse(viewStub.isSuccessCalled)
    }
}
