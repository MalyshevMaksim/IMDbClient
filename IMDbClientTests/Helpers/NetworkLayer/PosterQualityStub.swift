//
//  PosterQualityMock.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 10/19/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

class PosterQualityStub: PosterQualityProtocol {
    var baseUrl: URL? = URL.successUrl
    
    func makeNewQualityImageUrl(originalUrl: URL) -> URL? {
        return baseUrl
    }
}

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

class CacheGatewayMock: CacheGateway {
    var isImageCached = false
    var isMovieCollectionCached = false
    
    func addMovie(movie: Movie, forKey: String) {
        
    }
    
    func fetchMovie(forKey: String) -> Movie? {
        return nil
    }
    
    func addMovieCollection(forKey: String, collection: [Movie]) {
        isMovieCollectionCached = true
    }
    
    func fetchMovieCollection(forKey: String) -> [Movie]? {
        return nil
    }
    
    func addImage(image: UIImage, fromUrl: String) {
        isImageCached = true
    }
    
    func fetchImage(fromUrl: String) -> UIImage? {
        return nil
    }
    
    func getCountOfMovies() -> Int {
        return 0
    }
    
    func getCountOfCollections() -> Int {
        return 0
    }
}
