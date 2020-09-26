//
//  MovieList.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/8/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation

struct MovieList: Decodable {
    var items: [Movie]
    var errorMessage: String
}