//
//  MovieCell.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/3/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

class MovieTableViewCell: UITableViewCell, MovieCellProtocol {
    static var reuseIdentifier = "MovieTableCell"
    var activityView = UIActivityIndicatorView(style: .medium)
    
    lazy var poster: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var subtitle: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.numberOfLines = 3
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var imDbRating: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var imDbRatingCount: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var ratingTagView: RatingTagView = {
        let ratingTagView = RatingTagView(ratingLabel: imDbRating)
        ratingTagView.translatesAutoresizingMaskIntoConstraints = false
        return ratingTagView
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
        contentView.addSubview(imDbRatingCount)
        contentView.addSubview(subtitle)
    }
    
    private func setupCell() {
        setupSubviews()
        
        NSLayoutConstraint.activate([
            poster.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            poster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            poster.widthAnchor.constraint(equalToConstant: contentView.frame.width * 0.3),
            poster.heightAnchor.constraint(equalToConstant: contentView.frame.width * 0.41),

            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            title.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: 15),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        
            ratingTagView.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            ratingTagView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            
            imDbRatingCount.topAnchor.constraint(equalTo: ratingTagView.bottomAnchor, constant: 5),
            imDbRatingCount.leadingAnchor.constraint(equalTo: ratingTagView.leadingAnchor),
            
            subtitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            subtitle.leadingAnchor.constraint(equalTo: imDbRatingCount.leadingAnchor),
            subtitle.trailingAnchor.constraint(equalTo: title.trailingAnchor),
            
            contentView.layoutMarginsGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: poster.lastBaselineAnchor, multiplier: 0)
        ])
    }
}
