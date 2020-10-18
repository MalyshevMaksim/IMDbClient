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
    func execute<T: Decodable>(url: URL, comletionHandler: @escaping (Result<T?, Error>) -> ())
    func downloadImage(url: URL, completionHandler: @escaping (Result<UIImage, Error>) -> ())
    func cancelAllTasks()
}

class APIService: NetworkService {
    private var urlSession: URLSessionProtocol
    private var quality: PosterEndpoint
    
    init(quality: PosterEndpoint, urlSession: URLSessionProtocol = URLSession(configuration: URLSessionConfiguration.default)) {
        self.urlSession = urlSession
        self.quality = quality
    }
    
    func execute<T: Decodable>(url: URL, comletionHandler: @escaping (Result<T?, Error>) -> ()) {
        let dataTask = urlSession.dataTask(with: url) { data, response, error in
            guard let httpUrlResponse = response as? HTTPURLResponse, let data = data else {
                comletionHandler(.failure(NSError.makeError(withMessage: "Failed to get response")))
                return
            }
            if (200...299).contains(httpUrlResponse.statusCode) {
                do {
                    let convertedData = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async { comletionHandler(.success(convertedData)) }
                }
                catch {
                    DispatchQueue.main.async { comletionHandler(.failure(error)) }
                }
            }
            else {
                let error = NSError.makeError(withMessage: "Request failed: code \(httpUrlResponse.statusCode)")
                DispatchQueue.main.async { comletionHandler(.failure(error)) }
            }
        }
        dataTask.resume()
    }
    
    func downloadImage(url: URL, completionHandler: @escaping (Result<UIImage, Error>) -> ()) {
        guard let url = quality.makeNewQualityImageUrl(originalUrl: url) else {
            completionHandler(.failure(NSError.makeError(withMessage: "Failed to generate request url")))
            return
        }
        let dataTask = urlSession.dataTask(with: url) { data, response, error in
            guard let httpUrlResponse = response as? HTTPURLResponse, let data = data else {
                completionHandler(.failure(NSError.makeError(withMessage: "Failed to get response")))
                return
            }
            if (200...299).contains(httpUrlResponse.statusCode) {
                guard let image = UIImage(data: data) else {
                    DispatchQueue.main.async { completionHandler(.failure(NSError())) }
                    return
                }
                DispatchQueue.main.async { completionHandler(.success(image)) }
            }
            else {
                let error = NSError.makeError(withMessage: "Request failed: code \(httpUrlResponse.statusCode)")
                DispatchQueue.main.async { completionHandler(.failure(error)) }
            }
        }
        dataTask.resume()
    }
    
    func cancelAllTasks() {
       
    }
}
