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
    var quality: PosterEndpoint { get set }
    func execute<T: Decodable>(url: URL, comletionHandler: @escaping (Result<T?, Error>) -> ())
    func downloadImage(url: String, quality: PosterEndpoint, completionHandler: @escaping (Result<UIImage?, Error>) -> ())
}

class APIService: NetworkService {
    private var urlSession: URLSession
    private var parser: ParserProtocol
    var quality: PosterEndpoint
    
    init(quality: PosterEndpoint, urlSession: URLSession = URLSession(configuration: URLSessionConfiguration.default), parser: Parser = Parser()) {
        self.parser = parser
        self.urlSession = urlSession
        self.quality = quality
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
    
    func downloadImage(url: String, quality: PosterEndpoint, completionHandler: @escaping (Result<UIImage?, Error>) -> ()) {
        guard let url = quality.makeNewQualityImageUrl(originalUrl: url) else {
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { data, repsonse, error in
            guard error == nil else {
                completionHandler(.failure(error!))
                return
            }
            if let data = data, let image = UIImage(data: data) {
                completionHandler(.success(image))
            }
        }
        dataTask.resume()
    }
}
