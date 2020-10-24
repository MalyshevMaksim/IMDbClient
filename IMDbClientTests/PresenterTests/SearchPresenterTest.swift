//
//  SearchPresenterTest.swift
//  IMDbClientTests
//
//  Created by Малышев Максим Алексеевич on 10/23/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import XCTest
@testable import IMDbClient

class SearchPresenterTest: XCTestCase {
    var sut: MovieSearchPresenter!
    var viewStub: ViewStub!
    var downloaderStub: MovieDownloaderFacadeStub!
    var routerDummy: RouterDummy!
    
    var filteredMovieStub = [Movie(id: "1", title: "foo", image: "bar", crew: "baz"),
                             Movie(id: "1", title: "foo", image: "bar", crew: "baz"),
                             Movie(id: "1", title: "foo", image: "bar", crew: "baz")]

    override func setUp() {
        super.setUp()
        viewStub = ViewStub()
        downloaderStub = MovieDownloaderFacadeStub()
        routerDummy = RouterDummy()
        sut = MovieSearchPresenter(view: viewStub, movieDownloader: downloaderStub, router: routerDummy)
    }
    
    override func tearDown() {
        sut = nil
        viewStub = nil
        downloaderStub = nil
        routerDummy = nil
        super.tearDown()
    }
    
    func testGetCountOfMovies() {
        sut.filteredMovie = filteredMovieStub
        let count = sut.getCountOfMovies(section: 0)
        XCTAssertEqual(filteredMovieStub.count, count)
    }
    
    func testDownloadMoviesViewSuccess() {
        downloaderStub.successStub = true
        sut.downloadMovies()
        XCTAssertTrue(viewStub.isSuccessCalled)
    }
    
    func testDisplayCell() {
        let movie = filteredMovieStub.first
        let cellStub = MovieCellStub()
        sut.filteredMovie = filteredMovieStub
        sut.displayCell(cell: cellStub, in: 0, for: 0)
        XCTAssertEqual(cellStub.title, movie?.title)
        XCTAssertEqual(cellStub.subtitle, movie?.subtitle)
    }
}
