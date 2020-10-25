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
