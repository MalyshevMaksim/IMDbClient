//
//  TopModel.swift
//  IMDbAPI
//
//  Created by Малышев Максим Алексеевич on 9/2/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

struct Movie: Codable, Hashable {
    var id: String
    var title: String
    var image: String
    var crew: String?
    var plot: String?
    var description: String?
    var imDbRating: String?
    var imDbRatingCount: String?
    var runtimeStr: String?
    var year: String?
    var releaseDate: String?
    var contentRating: String?
    
    var subtitle: String {
        if let crew = crew {
            return crew
        }
        else if let plot = plot {
            return plot
        }
        else {
            return description!
        }
    }
}
