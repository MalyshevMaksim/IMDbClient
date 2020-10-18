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
}

extension URLSession: URLSessionProtocol { }

extension URL {
    static var defaultUrl: URL {
        return URL(string: "https://www.google.com")!
    }
}

extension HTTPURLResponse {
    convenience init(statusCode: Int) {
        self.init(url: URL.defaultUrl, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
    }
}
