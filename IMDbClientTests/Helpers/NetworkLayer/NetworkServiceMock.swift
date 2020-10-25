//
//  NetworkServiceMock.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 10/23/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

class NetworkServiceMock: NetworkService {
    var isCancelCalled = false
    var isCancelCalledBeforeExecute = false
    var url: URL!
    var dataStub: Data?
    
    init(dataStub: Data?) {
        self.dataStub = dataStub
    }
    
    func execute<T>(url: URL, comletionHandler: @escaping (Result<T?, Error>) -> ()) where T : Decodable {
        self.url = url
        isCancelCalledBeforeExecute = isCancelCalled ? true : false
        
        guard let data = dataStub, let convertedData = try? JSONDecoder().decode(T.self, from: data) else {
            comletionHandler(.failure(NSError.makeError(withMessage: "error")))
            return
        }
        comletionHandler(.success(convertedData))
    }
    
    func downloadImage(url: URL, completionHandler: @escaping (Result<UIImage, Error>) -> ()) {
        guard let data = dataStub, let image = UIImage(data: data) else {
            completionHandler(.failure(NSError.makeError(withMessage: "error")))
            return
        }
        completionHandler(.success(image))
    }
    
    func cancelAllTasks() {
        isCancelCalled = true
    }
}
