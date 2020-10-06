//
//  NetworkServiceProtocol.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/4/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import UIKit
import Foundation

protocol NetworkService {
    var posterEndpoint: PosterEndpoint { get }
    func execute<T: Decodable>(url: URL, comletionHandler: @escaping (Result<T?, Error>) -> ())
    func downloadImage(url: String, completionHandler: @escaping (Result<UIImage?, Error>) -> ())
}

class APIService: NetworkService {
    private var urlSession: URLSession
    private var parser: ParserProtocol
    internal var posterEndpoint: PosterEndpoint
    
    init(posterEndpoint: PosterEndpoint, parser: Parser = Parser(), urlSession: URLSession = URLSession(configuration: URLSessionConfiguration.default)) {
        self.posterEndpoint = posterEndpoint
        self.parser = parser
        self.urlSession = urlSession
    }
    
    func execute<T: Decodable>(url: URL, comletionHandler: @escaping (Result<T?, Error>) -> ()) {
        let dataTask = urlSession.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                comletionHandler(.failure(error!))
                return
            }
            self.parser.json(data: data, comletionHandler: comletionHandler)
        }
        dataTask.resume()
    }
    
    func downloadImage(url: String, completionHandler: @escaping (Result<UIImage?, Error>) -> ()) {
        guard let url = posterEndpoint.makeNewQualityImageUrl(originalUrl: url) else {
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { data, repsonse, error in
            guard let data = data, let image = UIImage(data: data), error == nil else {
                //completionHandler(.failure(error!))
                return
            }
            completionHandler(.success(image))
        }
        dataTask.resume()
    }
}
