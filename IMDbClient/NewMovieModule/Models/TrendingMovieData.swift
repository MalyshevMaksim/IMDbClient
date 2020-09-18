//
//  NewMovieData.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/14/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation

struct TrendingMovieData: Decodable {
    var items: [TrendingMovie]
    var errorMessage: String
}
