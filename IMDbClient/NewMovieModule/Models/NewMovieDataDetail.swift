//
//  NewMovieDataDetail.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/14/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation

struct NewMovie: Decodable, Hashable {
    var id: String
    var title: String
    var releaseState: String
    var image: String
    var plot: String
    var runtimeStr: String
    var genres: String
}
