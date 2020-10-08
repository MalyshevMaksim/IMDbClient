//
//  PosterQuality.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/21/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation

enum PosterEndpoint {
    case low, normal, original
    
    private var baseUrl: URL { return URL(string: "https://imdb-api.com/Images")! }
    
    func makeNewQualityImageUrl(originalUrl: String) -> URL? {
        let beginningPath = baseUrl.absoluteURL.absoluteString
        let lastPath = (originalUrl as NSString).lastPathComponent
        
        switch self {
            case .low:
                return URL(string: beginningPath + "/144x198/" + lastPath)
            case .normal:
                return URL(string: beginningPath + "/384x528/" + lastPath)
            case .original:
                return URL(string: beginningPath + "/original/" + lastPath)
        }
    }
}
