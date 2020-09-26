//
//  MovieCell.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/18/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import UIKit

extension MovieCell {
    func display(image: UIImage?) {
        DispatchQueue.main.async {
            UIView.transition(with: self.poster, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.poster.image = image
            })
        }
    }
    
    func display(title: String) {
        self.title.text = title
    }
    
    func display(subtitle: String) {
        self.subtitle.text = subtitle
    }
    
    func display(imDbRating: String) {
        self.imDbRating.text = imDbRating
    }
    
    func display(imDbRatingCount: String) {
        self.imDbRatingCount.text = imDbRatingCount
    }
    
    func startActivity() {
        DispatchQueue.main.async {
            let activityView = UIActivityIndicatorView(style: .medium)
            self.poster.addSubview(activityView)
            activityView.center = self.poster.center
            activityView.startAnimating()
        }
    }
    
    func stopActivity() {
        
    }
}
