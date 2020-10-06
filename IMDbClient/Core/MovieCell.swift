//
//  MovieCell.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/18/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import UIKit

protocol MovieCell {
    var activityView: UIActivityIndicatorView { get set }
    var poster: UIImageView { get set }
    var title: UILabel { get set }
    var imDbRating: UILabel { get set }
    var imDbRatingCount: UILabel { get set }
    var subtitle: UILabel { get set }
}

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
            self.poster.addSubview(activityView)
            activityView.hidesWhenStopped = true
            activityView.center = self.poster.center
            activityView.startAnimating()
        }
    }
    
    func stopActivity() {
        activityView.stopAnimating()
    }
}
