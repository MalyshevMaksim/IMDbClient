//
//  TopModel.swift
//  IMDbAPI
//
//  Created by Малышев Максим Алексеевич on 9/2/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

struct Movie: Decodable, Hashable {
    var id: String
    var title: String
    var fullTitle: String
    var image: String
    var imDbRating: String
    var imDbRatingCount: String
    var crew: String?
    var plot: String?
    
    var subtitle: String {
        if let crew = crew {
            return crew
        }
        else {
            return plot!
        }
    }
}
