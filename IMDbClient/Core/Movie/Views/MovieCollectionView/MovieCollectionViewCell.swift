//
//  NewMovieCollectionCell.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/14/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    var activityView = UIActivityIndicatorView(style: .medium)
    static var reuseIdentifier = "MovieTableCell"
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        addSubview(poster)
        addSubview(title)
        addSubview(subtitle)
    }
    
    private func setupView() {
        setupSubviews()
    
        NSLayoutConstraint.activate([
            poster.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 5),
            poster.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            poster.topAnchor.constraint(equalTo: contentView.topAnchor),
            poster.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.75),
            
            title.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 5),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            title.topAnchor.constraint(equalTo: poster.bottomAnchor, constant: 10),
            
            subtitle.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            subtitle.trailingAnchor.constraint(equalTo: title.trailingAnchor),
        ])
    }
}

extension MovieCollectionViewCell: MovieCellProtocol {
    func display(image: UIImage?) {
        UIView.transition(with: self.poster, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.poster.image = image
        })
    }
    
    func display(title: String) {
        self.title.text = title
    }
    
    func display(subtitle: String) {
        self.subtitle.text = subtitle
    }
    
    func display(imDbRating: String) {
        
    }
    
    func display(imDbRatingCount: String) {
        
    }
    
    func startActivity() {
        self.poster.addSubview(activityView)
        activityView.hidesWhenStopped = true
        activityView.center = poster.center
        activityView.startAnimating()
    }
    
    func stopActivity() {
        activityView.stopAnimating()
    }
}
