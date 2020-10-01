//
//  PosterQuality.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/21/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation

enum PosterEndpoint {
    case lowQuality, normalQuality, originalQuality
    
    var baseUrl: URL { return URL(string: "https://imdb-api.com/Images")! }
    
    func makeNewQualityImageUrl(originalUrl: String) -> URL? {
        let beginningPath = baseUrl.absoluteURL.absoluteString
        let lastPath = (originalUrl as NSString).lastPathComponent
        
        switch self {
            case .lowQuality:
                return URL(string: beginningPath + "/192x264/" + lastPath)
            case .normalQuality:
                return URL(string: beginningPath + "/384x528/" + lastPath)
            case .originalQuality:
                return URL(string: beginningPath + "/original/" + lastPath)
        }
    }
}
