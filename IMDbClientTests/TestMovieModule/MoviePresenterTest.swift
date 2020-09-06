//
//  MoviePresenterTest.swift
//  IMDbClientTests
//
//  Created by Малышев Максим Алексеевич on 9/5/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import XCTest
@testable import IMDbClient


class MockNetworkService: MovieNetworkServiceProtocol {
    func getTopRatedMovies(completion: @escaping (Result<TopMovies?, Error>) -> ()) {
        
    }
    
    func getMostPopularMovies(completion: @escaping (Result<TopMovies?, Error>) -> ()) {
        
    }
}

class MoviePresenterTest: XCTestCase {
    
}
