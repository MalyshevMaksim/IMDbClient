//
//  URLSession+URLSessionProtocol.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 10/15/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation

protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    func dataTask(with request: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask
    func getAllTasks(completionHandler: @escaping ([URLSessionTask]) -> Void)
}

extension URLSession: URLSessionProtocol { }

extension URL {
    static public var successUrl: URL? {
        return URL(string: "https://www.google.com")
    }
    
    static public var failureUrl: URL? {
        return URL(string: "")
    }
}

extension HTTPURLResponse {
    convenience init(statusCode: Int) {
        self.init(url: URL.successUrl!, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
    }
}
