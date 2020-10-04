//
//  SearchResult.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 10/1/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation

struct SearchResult: Decodable {
    var id: String
    var image: String
    var title: String
    var description: String
}
