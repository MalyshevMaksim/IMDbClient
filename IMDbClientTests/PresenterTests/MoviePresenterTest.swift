//
//  MoviePresenterTest.swift
//  IMDbClientTests
//
//  Created by Малышев Максим Алексеевич on 10/22/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import XCTest
@testable import IMDbClient

class MoviePresenterTest: XCTestCase {
    var sut: MoviePresenter!
    var viewStub: ViewStub!
    var routerDummy: RouterDummy!
    var downloaderStub: MovieDownloaderFacadeStub!
    
    var isFiltered = false
    var filteredMovieStub = [Movie(id: "1", title: "foo", image: "bar", crew: "baz"),
                             Movie(id: "2", title: "foo", image: "bar", crew: "baz", plot: nil, description: nil, imDbRating: "10", imDbRatingCount: "10"),
                             Movie(id: "3", title: "foo", image: "bar", crew: "baz")]
    
    override func setUp() {
        super.setUp()
        viewStub = ViewStub()
        downloaderStub = MovieDownloaderFacadeStub()
        routerDummy = RouterDummy()
        sut = MoviePresenter(view: viewStub, movieDownloader: downloaderStub, router: routerDummy)
    }
    
    override func tearDown() {
        sut = nil
        viewStub = nil
        downloaderStub = nil
        super.tearDown()
    }
    
    func testDisplayCellGetMovieFail() {
        sut.filteredMovie = []
        let cellStub = MovieCellStub()
        sut.displayCell(cell: cellStub, in: 0, for: 0)
        
        XCTAssertNil(cellStub.title)
        XCTAssertNil(cellStub.subtitle)
        XCTAssertNil(cellStub.imDbRating)
        XCTAssertNil(cellStub.imtDbRatingCount)
        XCTAssertNil(cellStub.image)
    }
    
    func testDisplayCellWithRating() {
        sut.filteredMovie = filteredMovieStub
        let movie = filteredMovieStub[1]
        let cellStub = MovieCellStub()
        sut.displayCell(cell: cellStub, in: 0, for: 1)
        
        XCTAssertEqual(cellStub.imDbRating, "⭐️ \(movie.imDbRating!) IMDb")
        XCTAssertEqual(cellStub.imtDbRatingCount, "based on \(movie.imDbRatingCount!) user ratings")
        XCTAssertTrue(cellStub.isActivityStarted)
        XCTAssertTrue(cellStub.isActivityStopped)
    }
    
    func testDisplayCellWithoutRating() {
        sut.filteredMovie = filteredMovieStub
        let movie = filteredMovieStub.first
        let cellStub = MovieCellStub()
        sut.displayCell(cell: cellStub, in: 0, for: 0)
        
        XCTAssertEqual(cellStub.title, movie?.title)
        XCTAssertEqual(cellStub.subtitle, movie?.subtitle)
        XCTAssertEqual(cellStub.imDbRating, "⭐️ No ratings")
        XCTAssertEqual(cellStub.imtDbRatingCount, "Ratings for this movie are not yet available")
        XCTAssertTrue(cellStub.isActivityStarted)
        XCTAssertTrue(cellStub.isActivityStopped)
    }
    
    func testGetCountOfMoviesWithFiltered() {
        sut.filteredMovie = filteredMovieStub
        let count = sut.getCountOfMovies(section: 0)
        XCTAssertEqual(filteredMovieStub.count, count)
    }
    
    func testGetCountOfMoviesWithoutFiltered() {
        sut.filteredMovie = []
        sut.getCountOfMovies(section: 0)
        XCTAssertTrue(downloaderStub.isGetCountOfMoviesCalled)
    }
    
    func testDownloadMoviesViewSuccess() {
        downloaderStub.successStub = true
        sut.downloadMovies()
        XCTAssertTrue(viewStub.isSuccessCalled)
    }
    
    func testDownloadMoviesViewFailure() {
        downloaderStub.successStub = false
        sut.downloadMovies()
        XCTAssertFalse(viewStub.isSuccessCalled)
    }
}
