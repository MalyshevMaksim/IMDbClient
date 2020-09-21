//
//  PosterQuality.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/21/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation

enum PosterQuality {
    case low, normal, original, square
    
    func makeNewImageUrl(originalUrl: String) -> URL? {
        let beginningPath = "https://imdb-api.com/Images"
        let lastPath = (originalUrl as NSString).lastPathComponent
        
        switch self {
            case .low: return URL(string: beginningPath + "/192x264/" + lastPath)
            case .normal: return URL(string: beginningPath + "/384x528/" + lastPath)
            case .original: return URL(string: beginningPath + "/original/" + lastPath)
            case .square: return URL(string: "https://imdb-api.com/Posters/s230/" + lastPath)
        }
    }
}
