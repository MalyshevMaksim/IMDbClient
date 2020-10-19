//
//  NetworkServiceTest.swift
//  IMDbClientTests
//
//  Created by Малышев Максим Алексеевич on 10/15/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import XCTest
@testable import IMDbClient

typealias URLSessionCompletionHandlerResponse = (data: Data?, response: URLResponse?, error: Error?)

class URLSessionMock: URLSessionProtocol {
    var responses = [URLSessionCompletionHandlerResponse]()
    var dataTask: DataTaskMock!
    var sourceUrl: URL!
    var countOfTasks = 0
    var dataTasksStub = [DataTaskMock(stubResponse: nil, completionHandler: nil),
                         DataTaskMock(stubResponse: nil, completionHandler: nil),
                         DataTaskMock(stubResponse: nil, completionHandler: nil)]
    
    func enqueue(response: URLSessionCompletionHandlerResponse) {
        responses.append(response)
    }
    
    func getAllTasks(completionHandler: @escaping ([URLSessionTask]) -> Void) {
        completionHandler(dataTasksStub)
    }
    
    func dataTask(with url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask {
        self.dataTask = DataTaskMock(stubResponse: responses.removeFirst(), completionHandler: completionHandler)
        self.sourceUrl = url
        return dataTask
    }
}

class DataTaskMock: URLSessionDataTask {
    let completionHandler: ((Data?, URLResponse?, Error?) -> ())?
    let stubHttpResponse: URLSessionCompletionHandlerResponse?
    static var countCancelled = 0
    
    init(stubResponse: URLSessionCompletionHandlerResponse?, completionHandler: ((Data?, URLResponse?, Error?) -> ())?) {
        self.stubHttpResponse = stubResponse
        self.completionHandler = completionHandler
    }
    
    override func cancel() {
        DataTaskMock.countCancelled += 1
    }
    
    override func resume() {
        completionHandler!(stubHttpResponse?.data, stubHttpResponse?.response, stubHttpResponse?.error)
    }
}

class PosterQualityMock: PosterQualityProtocol {
    var baseUrl: URL? = URL.successUrl
    
    func makeNewQualityImageUrl(originalUrl: URL) -> URL? {
        return baseUrl
    }
}

class NetworkServiceTest: XCTestCase {
    var urlSessionMock = URLSessionMock()
    var posterQualityMock = PosterQualityMock()
    var sut: NetworkService!
    
    var successResponseStub = HTTPURLResponse(statusCode: 200)
    var failureResponseStub = HTTPURLResponse(statusCode: 404)
    
    var successExecuteDataStub = ("{\"SomeProperty\":\"SomeValue\"}").data(using: .utf8)
    var failureExecuteDataStub = ("{ \"Foo\" : \"Bar\" }").data(using: .utf8)
    
    override func setUp() {
        super.setUp()
        sut = APIService(quality: posterQualityMock, urlSession: urlSessionMock)
    }
    
    override func tearDown() {
        DataTaskMock.countCancelled = 0
        sut = nil
        super.tearDown()
    }
    
    
    // MARK: EXECUTE TESTS
    
    private func executeFailureExpected(expectation: XCTestExpectation) {
        sut.execute(url: URL.successUrl) { (result: Result<ExecuteStubEntity?, Error>) in
            if (try? result.get()) != nil {
                XCTFail("Expected status code error to be thrown")
            }
            expectation.fulfill()
        }
    }
    
    func testExecuteStatusCodeFailure() {
        urlSessionMock.enqueue(response: (data: successExecuteDataStub, response: failureResponseStub, error: nil))
        let statusCodeFailureCompletionExpectation = expectation(description: "Failure completion handler expectation")
        executeFailureExpected(expectation: statusCodeFailureCompletionExpectation)
        wait(for: [statusCodeFailureCompletionExpectation], timeout: 1)
    }
    
    func testExecuteResponseFailure() {
        urlSessionMock.enqueue(response: (data: nil, response: nil, error: nil))
        let responseFailureCompletionExpectation = expectation(description: "Failure completion handler expectation")
        executeFailureExpected(expectation: responseFailureCompletionExpectation)
        wait(for: [responseFailureCompletionExpectation], timeout: 1)
    }
    
    func testExecuteParseFailure() {
        urlSessionMock.enqueue(response: (data: failureExecuteDataStub, response: successResponseStub, error: nil))
        let parseFailureCompletionExpectation = expectation(description: "Failure completion handler expectation")
        executeFailureExpected(expectation: parseFailureCompletionExpectation)
        wait(for: [parseFailureCompletionExpectation], timeout: 1)
    }
    
    func testExecuteParseSuccessful() {
        urlSessionMock.enqueue(response: (data: successExecuteDataStub, response: successResponseStub, error: nil))
        let parseCompletionExpectation = expectation(description: "Successful completion handler expectation")
        
        sut.execute(url: URL.successUrl) { (result: Result<ExecuteStubEntity?, Error>) in
            guard let _ = try? result.get() else {
                XCTFail("A successfull response should've been returned")
                return
            }
            parseCompletionExpectation.fulfill()
        }
        wait(for: [parseCompletionExpectation], timeout: 1)
    }
    
    
    // MARK: DOWNLOAD IMAGE TESTS
    
    private func downloadImageFailureExpected(expectation: XCTestExpectation) {
        sut.downloadImage(url: URL.successUrl) { (result: Result<UIImage, Error>) in
            if (try? result.get()) != nil {
                XCTFail("Error was expected")
            }
            expectation.fulfill()
        }
    }

    func testDownloadImageConvertedDataSuccessful() {
        let convertedDataSuccessfulCompletionExpectation = expectation(description: "Successful completion handler expectation")
        let successDataStub = UIImage(systemName: "folder.fill")!.pngData()
        urlSessionMock.enqueue(response: (data: successDataStub, response: successResponseStub, error: nil))
        
        sut.downloadImage(url: URL.successUrl) { (result: Result<UIImage, Error>) in
            guard let _ = try? result.get() else {
                XCTFail("Successfull was expected")
                return
            }
            convertedDataSuccessfulCompletionExpectation.fulfill()
        }
        wait(for: [convertedDataSuccessfulCompletionExpectation], timeout: 1)
    }
    
    func testDownloadImageConvertedDataFailure() {
        let convertedDataFailureCompletionExpectation = expectation(description: "Failure completion handler expectation")
        urlSessionMock.enqueue(response: (data: failureExecuteDataStub, response: successResponseStub, error: nil))
        downloadImageFailureExpected(expectation: convertedDataFailureCompletionExpectation)
        wait(for: [convertedDataFailureCompletionExpectation], timeout: 1)
    }
    
    func testDownloadImageStatusCodeFailure() {
        urlSessionMock.enqueue(response: (data: successExecuteDataStub, response: failureResponseStub, error: nil))
        let statusCodeFailureCompletionExpectation = expectation(description: "Failure completion handler expectation")
        downloadImageFailureExpected(expectation: statusCodeFailureCompletionExpectation)
        wait(for: [statusCodeFailureCompletionExpectation], timeout: 1)
    }
    
    func testDownloadImageResponseFailure() {
        urlSessionMock.enqueue(response: (data: nil, response: nil, error: nil))
        let responseFailureCompletionExpectation = expectation(description: "Failure completion handler expectation")
        downloadImageFailureExpected(expectation: responseFailureCompletionExpectation)
        wait(for: [responseFailureCompletionExpectation], timeout: 1)
    }
    
    func testDownloadImageFailureGenerateURL() {
        let urlGenerateFailureCompletionExpectation = expectation(description: "Failure completion handler expectation")
        urlSessionMock.enqueue(response: (data: successExecuteDataStub, response: successResponseStub, error: nil))
        posterQualityMock.baseUrl = nil
        downloadImageFailureExpected(expectation: urlGenerateFailureCompletionExpectation)
        wait(for: [urlGenerateFailureCompletionExpectation], timeout: 1)
    }
    
    
    // MARK: GENERAL TESTS
    
    func testJSONResponseWithoutErrors() {
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
        XCTAssertEqual(errorMessage, "", errorMessage)
    }
    
    func testAllCancelTask() {
        sut.cancelAllTasks()
        XCTAssertEqual(urlSessionMock.dataTasksStub.count, DataTaskMock.countCancelled, "Not all tasks have been canceled")
    }
}

private struct ExecuteStubEntity: Codable {
    var SomeProperty: String
    
    var utf8String: String {
        let data = try? JSONEncoder().encode(self)
        return String(data: data!, encoding: .utf8)!
    }
}
