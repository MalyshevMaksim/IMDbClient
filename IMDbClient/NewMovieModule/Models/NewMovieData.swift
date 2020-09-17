//
//  NewMovieData.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/14/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation

struct NewMovieData: Decodable {
    var items: [NewMovie]
    var errorMessage: String
}
