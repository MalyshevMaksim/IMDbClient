//
//  MovieCell.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/3/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

protocol MovieCell {
    func display(image: UIImage?)
    func display(title: String)
    func display(imDbRating: String)
    func display(ratingCount: String)
    func display(crew: String)
    func startActivity()
    func stopActivity()
}

class MovieTableViewCell: UITableViewCell {
    static var reuseIdentifier = "MovieTableCell"
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var poster: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var ratingTagView: RatingTagView = {
        let ratingTagView = RatingTagView()
        ratingTagView.translatesAutoresizingMaskIntoConstraints = false
        return ratingTagView
    }()
    
    lazy var ratingCount: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var crew: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.numberOfLines = 2
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        contentView.addSubview(title)
        contentView.addSubview(poster)
        contentView.addSubview(ratingTagView)
        contentView.addSubview(ratingCount)
        contentView.addSubview(crew)
    }
    
    private func setupCell() {
        setupSubviews()
        
        NSLayoutConstraint.activate([
            poster.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            poster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            poster.widthAnchor.constraint(equalToConstant: contentView.frame.width * 0.3),
            poster.heightAnchor.constraint(equalToConstant: contentView.frame.width * 0.41),

            title.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: 15),
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        
            ratingTagView.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            ratingTagView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            
            ratingCount.topAnchor.constraint(equalTo: ratingTagView.bottomAnchor, constant: 5),
            ratingCount.leadingAnchor.constraint(equalTo: ratingTagView.leadingAnchor),
            
            crew.bottomAnchor.constraint(equalTo: poster.bottomAnchor),
            crew.leadingAnchor.constraint(equalTo: ratingCount.leadingAnchor),
            crew.trailingAnchor.constraint(equalTo: title.trailingAnchor),
            
            contentView.layoutMarginsGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: poster.lastBaselineAnchor, multiplier: 0)
        ])
    }
}

extension MovieTableViewCell: MovieCell {
    func display(image: UIImage?) {
        UIView.transition(with: self, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.poster.image = image
        })
    }
    
    func display(ratingCount: String) {
        self.ratingCount.text = ratingCount
    }
    
    func display(title: String) {
        self.title.text = title
    }
    
    func display(crew: String) {
        self.crew.text = crew
    }
    
    func display(imDbRating: String) {
        self.ratingTagView.rating.text = imDbRating
    }
    
    func display(image: UIImageView) {
        poster = image
    }
    
    func startActivity() {
        poster.addSubview(activityIndicator)
        activityIndicator.hidesWhenStopped = true
        
        DispatchQueue.main.async {
            self.activityIndicator.center = CGPoint(x: self.poster.bounds.width / 2, y: self.poster.bounds.height / 2)
            self.activityIndicator.startAnimating()
        }
    }
    
    func stopActivity() {
        activityIndicator.stopAnimating()
    }
}
