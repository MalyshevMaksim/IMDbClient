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
    func dataTask(with url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        return DataTaskMock(completionHandler: completionHandler)
    }
    
    func successHttpResponse(url: URL) -> URLResponse {
        return HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
}

class DataTaskMock: URLSessionDataTask {
    let completionHandler: (Data?, URLResponse?, Error?) -> Void
    var isResumeCalled = false
    
    init(completionHandler: @escaping (Data?, URLResponse?, Error?) -> ()) {
        self.completionHandler = completionHandler
    }
    
    override func resume() {
        isResumeCalled = true
    }
}

class NetworkServiceTest: XCTestCase {
    var urlSessionMock = URLSessionMock()
    var sut: NetworkService!
    
    override func setUp() {
        super.setUp()
        sut = APIService(quality: .low, urlSession: urlSessionMock)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testExecuteNon2xxResponseCode() {
        let executeExpectation = expectation(description: "Completion handler expectation")
        let url = URL(string: "https://google.com")!
        
        sut.execute(url: url) { (result: Result<MovieList?, Error>) in
            
            do {
                let _ = try result.get()
            } catch {
                XCTFail("Err")
            }
            
            executeExpectation.fulfill()
        }
        wait(for: [executeExpectation], timeout: 2)
    }
    
    func testResumeIsCalled() {
        sut.execute(url: URL(string: "foo")!) { (result: Result<Movie?, Error>) in }
        XCTAssertEqual(urlSessionMock.dataTask.isResumeCalled, true, "resume() is not called")
        
        urlSessionMock.dataTask.isResumeCalled = false
        
        sut.downloadImage(url: URL(string: "foo")!) { result in }
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
        
        wait(for: [promise], timeout: 2)
        XCTAssertEqual(errorMessage, "")
    }
}
