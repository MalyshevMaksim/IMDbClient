//
//  NetworkServiceProtocol.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/4/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

protocol NetworkClient {
    var posterQuality: PosterQuality { get }
    func execute<T: Decodable>(request: APIRequest, comletionHandler: @escaping (Result<T?, Error>) -> ())
    func downloadPoster(url: String, completionHandler: @escaping (Result<UIImage?, Error>) -> ())
}

class APIClient: NetworkClient {
    var posterQuality: PosterQuality
    
    init(posterQuality: PosterQuality) {
        self.posterQuality = posterQuality
    }
    
    func execute<T: Decodable>(request: APIRequest, comletionHandler: @escaping (Result<T?, Error>) -> ()) {
        let dataTask = URLSession.shared.dataTask(with: request.urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                comletionHandler(.failure(error!))
                return
            }
            self.jsonEncoding(data: data, comletionHandler: comletionHandler)
        }
        dataTask.resume()
    }
    
    private func jsonEncoding<T: Decodable>(data: Data, comletionHandler: @escaping (Result<T?, Error>) -> ()) {
        do {
            let jsonDecoder = JSONDecoder()
            let movieJson = try jsonDecoder.decode(T.self, from: data)
            comletionHandler(.success(movieJson))
        }
        catch {
            comletionHandler(.failure(error))
        }
    }
    
    func downloadPoster(url: String, completionHandler: @escaping (Result<UIImage?, Error>) -> ()) {
        guard let url = posterQuality.makeNewImageUrl(originalUrl: url) else {
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { data, repsonse, error in
            guard let data = data, let image = UIImage(data: data), error == nil else {
                // completionHandler(.failure(error))
                return
            }
            completionHandler(.success(image))
        }
        dataTask.resume()
    }
}
