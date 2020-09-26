//
//  DownloadMovieRequest.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/17/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation

protocol APIRequest {
    var urlRequest: URLRequest { get }
}

class DownloadMovieRequest: APIRequest {
    private var movieCollectionType: MovieCollectionType
    
    init(movieCollectionType: MovieCollectionType) {
        self.movieCollectionType = movieCollectionType
    }
    
    var urlRequest: URLRequest {
        guard let url = URL(string:movieCollectionType.resourceUrl) else {
            fatalError("Error")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}
