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
    func downloadImage(url: String, completionHandler: @escaping (Result<UIImage?, Error>) -> ())
    func cancelAllTasks()
}

class APIService: NetworkService {
    private var urlSession: URLSession
    private var imageDownloadTask: URLSessionTask?
    private var movieDownloadTask: URLSessionTask?
    var quality: PosterEndpoint
    
    init(quality: PosterEndpoint, urlSession: URLSession = URLSession(configuration: URLSessionConfiguration.default)) {
        self.urlSession = urlSession
        self.quality = quality
    }
    
    func execute<T: Decodable>(url: URL, comletionHandler: @escaping (Result<T?, Error>) -> ()) {
        movieDownloadTask = urlSession.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                comletionHandler(.failure(error!))
                return
            }
            do {
                let movieJson = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    comletionHandler(.success(movieJson))
                }
            }
            catch {
                DispatchQueue.main.async {
                    comletionHandler(.failure(error))
                }
            }
        }
        movieDownloadTask?.resume()
    }
    
    func downloadImage(url: String, completionHandler: @escaping (Result<UIImage?, Error>) -> ()) {
        guard let url = quality.makeNewQualityImageUrl(originalUrl: url) else {
            return
        }
        imageDownloadTask = URLSession.shared.dataTask(with: url) { data, repsonse, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    completionHandler(.failure(error!))
                }
                return
            }
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completionHandler(.success(image))
                }
            }
        }
        imageDownloadTask?.resume()
    }
    
    func cancelAllTasks() {
        movieDownloadTask?.cancel()
        imageDownloadTask?.cancel()
    }
}
