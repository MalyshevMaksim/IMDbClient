//
//  PosterQuality.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/21/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation

protocol PosterQualityProtocol {
    var baseUrl: URL? { get }
    func makeNewQualityImageUrl(originalUrl: URL) -> URL?
}

class PosterQualityEndpoint: PosterQualityProtocol {
    enum Quality {
        case low
        case normal
        case original
    }
    
    var baseUrl: URL? { return URL(string: "https://imdb-api.com/images") }
    var quality: Quality
    
    init(quality: Quality) {
        self.quality = quality
    }
    
    func makeNewQualityImageUrl(originalUrl: URL) -> URL? {
        let beginningPath = baseUrl!.absoluteURL.absoluteString
        let lastPath = (originalUrl.absoluteString as NSString).lastPathComponent
        
        switch quality {
            case .low:
                return URL(string: beginningPath + "/144x198/" + lastPath)
            case .normal:
                return URL(string: beginningPath + "/384x528/" + lastPath)
            case .original:
                return URL(string: beginningPath + "/original/" + lastPath)
        }
    }
}
