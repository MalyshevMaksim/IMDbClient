//
//  MovieDetailViewProtocol.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 10/6/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

protocol MovieDetailViewProtocol {
    var poster: UIImageView { get set }
    var movieTitle: UILabel { get set }
    var imDbRating: UILabel { get set }
    var length: UILabel { get set }
    var releaseDate: UILabel { get set }
    var contentRating: UILabel { get set }
    var plot: UILabel { get set }
    var starStack: RatingStackView { get set }
}

extension MovieDetailViewProtocol {
    func display(image: UIImage?) {
        self.poster.image = image
    }
    
    func display(title: String) {
        self.movieTitle.text = title
    }
    
    func display(imDbRating: String) {
        self.imDbRating.text = imDbRating
        self.starStack.rating = Double(imDbRating)
    }
    
    func display(length: String) {
        self.length.text = length
    }
    
    func display(releaseDate: String) {
        self.releaseDate.text = releaseDate
    }
    
    func display(contentRating: String) {
        self.contentRating.text = contentRating
    }
    
    func display(plot: String) {
        self.plot.text = plot
    }
    
    func display(rating: String) {
        self.imDbRating.text = rating
    }
}
