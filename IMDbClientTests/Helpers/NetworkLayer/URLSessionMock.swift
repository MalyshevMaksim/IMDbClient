//
//  URLSessionMock.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 10/19/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation

typealias URLSessionCompletionHandlerResponse = (data: Data?, response: URLResponse?, error: Error?)

class URLSessionMock: URLSessionProtocol {
    var responses = [URLSessionCompletionHandlerResponse]()
    var dataTask: DataTaskMock!
    var sourceUrl: URL!
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
