//
//  ApiRequestMock.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 10/23/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation

class APIRequestMock: APIRequest {
    enum URLState {
        case success
        case failure
    }
    
    static var numberOfRequests = 0
    var state: URLState
    
    init(state: URLState) {
        self.state = state
    }
    
    var urlRequest: URLRequest? {
        APIRequestMock.numberOfRequests += 1
        
        switch state {
            case .success:
                return URLRequest(url: URL.successUrl!)
            case .failure:
                return nil
        }
    }
}
