//
//  NetworkServiceTest.swift
//  IMDbClientTests
//
//  Created by Малышев Максим Алексеевич on 10/15/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import XCTest
@testable import IMDbClient

class NetworkServiceTest: XCTestCase {
    var networkService: NetworkService!
    var urlSession: URLSession!
    
    override func setUp() {
        super.setUp()
        urlSession = URLSession(configuration: .default)
        networkService = APIService(quality: .low, urlSession: urlSession)
    }
    
    override func tearDown() {
        urlSession = nil
        networkService = nil
        super.tearDown()
    }
    
    func testValidCallToGetsHTTPStatusCode200() {
        let APIKey = AppDelegate.APIKey
        let url = URL(string: "https://imdb-api.com/en/API/Top250Movies/\(APIKey)")
        let promise = expectation(description: "Status code: 200")
        
        let dataTask = urlSession.dataTask(with: url!) { data, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            }
            if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                }
                else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
    }
}
