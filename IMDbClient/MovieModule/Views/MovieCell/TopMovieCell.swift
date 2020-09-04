//
//  MovieCell.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/3/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

class TopMovieCell: UITableViewCell {
    static var reuseIdentifier = "MovieTableCell"
    
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
    
    lazy var ratingTagView: TagLabelView = {
        let ratingTagView = TagLabelView()
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
            poster.widthAnchor.constraint(equalToConstant: 90),
            poster.heightAnchor.constraint(equalToConstant: 130),

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
