//
//  File.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 10/23/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

class MovieCellStub: MovieCellProtocol {
    var title: String?
    var subtitle: String?
    var imDbRating: String?
    var imtDbRatingCount: String?
    var image: UIImage?
    var isActivityStarted = false
    var isActivityStopped = false
    
    func display(title: String) {
        self.title = title
    }
    
    func display(subtitle: String) {
        self.subtitle = subtitle
    }
    
    func display(imDbRating: String) {
        self.imDbRating = imDbRating
    }
    
    func display(imDbRatingCount: String) {
        self.imtDbRatingCount = imDbRatingCount
    }
    
    func display(image: UIImage?) {
        self.image = image
    }
    
    func startActivity() {
        isActivityStarted = true
    }
    
    func stopActivity() {
        isActivityStopped = true
    }
}
