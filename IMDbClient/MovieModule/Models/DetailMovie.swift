//
//  DetailMovie.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/3/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation

struct DetailMovie: Decodable {
    var image: String
    var title: String
    var imDbRating: String
    var runtimeStr: String
    var year: String
    var releaseDate: String
    var contentRating: String
}
