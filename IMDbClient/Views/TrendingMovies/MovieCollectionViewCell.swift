//
//  NewMovieCollectionCell.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/14/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

class MovieCollectionViewCell: UICollectionViewCell, MovieCell {
    static var reuseIdentifier = "MovieTableCell"
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    lazy var poster: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var subtitle: UILabel = {
       let label = UILabel()
       label.font = UIFont.preferredFont(forTextStyle: .footnote)
       label.textColor = .secondaryLabel
       label.numberOfLines = 2
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    lazy var imDbRating: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var imDbRatingCount: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        addSubview(poster)
        addSubview(title)
        addSubview(subtitle)
    }
    
    private func configure() {
        setupSubviews()
    
        NSLayoutConstraint.activate([
            poster.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 5),
            poster.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            poster.topAnchor.constraint(equalTo: contentView.topAnchor),
            poster.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7),
            
            title.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 5),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            title.bottomAnchor.constraint(equalTo: subtitle.topAnchor, constant: -5),
            
            subtitle.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 5),
            subtitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            subtitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
