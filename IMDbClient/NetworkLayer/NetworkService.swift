//
//  NetworkServiceProtocol.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/4/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation

protocol NetworkService {
    func execute<T: Decodable>(request: APIRequest, comletionHandler: @escaping (Result<T?, Error>) -> ())
}

class NetworkServiceClient: NetworkService {
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
}
