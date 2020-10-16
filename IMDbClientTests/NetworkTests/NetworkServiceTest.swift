//
//  NetworkServiceTest.swift
//  IMDbClientTests
//
//  Created by Малышев Максим Алексеевич on 10/15/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import XCTest
@testable import IMDbClient

class URLSessionMock: URLSessionProtocol {
    var dataTask = DataTaskMock()
    var data: Data?
    var error: Error?
    
    func dataTask(with url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        completionHandler(data, successHttpResponse(url: url), error)
        return dataTask
    }
    
    func successHttpResponse(url: URL) -> URLResponse {
        return HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
}

class DataTaskMock: URLSessionDataTaskProtocol {
    var isResumeCalled = false
    
    func resume() {
        isResumeCalled = true
    }
}

class NetworkServiceTest: XCTestCase {
    var urlSessionMock = URLSessionMock()
    var networkService: NetworkService!
    
    override func setUp() {
        super.setUp()
        networkService = APIService(quality: .low, urlSession: urlSessionMock)
    }
    
    override func tearDown() {
        networkService = nil
        super.tearDown()
    }
    
    func testResumeIsCalled() {
        networkService.execute(url: URL(string: "foo")!) { (result: Result<Movie?, Error>) in }
        XCTAssertEqual(urlSessionMock.dataTask.isResumeCalled, true, "resume() is not called")
        
        urlSessionMock.dataTask.isResumeCalled = false
        
        networkService.downloadImage(url: URL(string: "foo")!) { result in }
        XCTAssertEqual(urlSessionMock.dataTask.isResumeCalled, true, "resume() is not called")
    }
    
    func testGettingJSONResponseWithoutErrors() {
        // The test verifies the successful receipt of a response from the server
        // The test will fail if an invalid API key is specified, if the request stock is exhausted,
        // or if you receive another error from the server
        
        let urlSession = URLSession(configuration: .default)
        let APIKey = AppDelegate.APIKey
        let url = URL(string: "https://imdb-api.com/en/API/Top250Movies/\(APIKey)")
        let promise = expectation(description: "Getting a JSON response without errors")
        var errorMessage = ""
        
        urlSession.dataTask(with: url!) { data, response, error in
            let convertedMovie = try! JSONDecoder().decode(MovieList.self, from: data!)
            errorMessage = convertedMovie.errorMessage
            promise.fulfill()
        }.resume()
        
        wait(for: [promise], timeout: 5)
        XCTAssertEqual(errorMessage, "")
    }
}
