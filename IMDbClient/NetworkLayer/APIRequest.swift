//
//  DownloadMovieRequest.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/17/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation

protocol APIRequest {
    var urlRequest: URLRequest? { get }
}

class GETMovieRequest: APIRequest {
    private var endpoint: MovieEndpoint
    
    init(endpoint: MovieEndpoint) {
        self.endpoint = endpoint
    }
    
    var urlRequest: URLRequest? {
        guard let url = URL(string: endpoint.resourceUrl) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}
