//
//  DataTaskMock.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 10/19/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation

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
