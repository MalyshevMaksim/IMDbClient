//
//  InMemoryCacheTest.swift
//  IMDbClientTests
//
//  Created by Малышев Максим Алексеевич on 10/16/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import XCTest
@testable import IMDbClient

class CacheTest: XCTestCase {
    var sut: CacheGateway!
    var stubMovies = [Movie(id: "1", title: "foo", image: "bar", imDbRating: "baz"),
                      Movie(id: "2", title: "foo", image: "bar", imDbRating: "baz")]
    
    override func setUp() {
        super.setUp()
        sut = InMemoryCache()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testMovieCollectionsReadAndWrite() {
        sut.addMovieCollection(forKey: "foo", collection: stubMovies)
        let fetchedMovies = sut.fetchMovieCollection(forKey: "foo")
        XCTAssertEqual(stubMovies, fetchedMovies)
    }
    
    func testMovieReadAndWrite() {
        var readMovies: [Movie] = []
        
        for movie in stubMovies {
            sut.addMovie(movie: movie, forKey: movie.id)
        }
        XCTAssertEqual(sut.getCountOfMovies(), stubMovies.count)
        
        for movie in stubMovies {
            readMovies.append(sut.fetchMovie(forKey: movie.id)!)
        }
        XCTAssertEqual(readMovies, stubMovies)
    }
    
    func testCountOfMovie() {
        for movie in stubMovies {
            sut.addMovie(movie: movie, forKey: movie.id)
        }
        XCTAssertEqual(sut.getCountOfMovies(), stubMovies.count)
    }
}
