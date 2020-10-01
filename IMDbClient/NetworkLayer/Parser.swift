//
//  Parser.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 10/1/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation

protocol ParserProtocol {
    func json<T: Decodable>(data: Data, comletionHandler: @escaping (Result<T?, Error>) -> ())
}

class Parser: ParserProtocol {
    private let jsonDecoder = JSONDecoder()
    
    func json<T: Decodable>(data: Data, comletionHandler: @escaping (Result<T?, Error>) -> ()) {
        do {
            let movieJson = try jsonDecoder.decode(T.self, from: data)
            comletionHandler(.success(movieJson))
        }
        catch {
            comletionHandler(.failure(error))
        }
    }
}
