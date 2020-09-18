//
//  NewMovieCollectionCell.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/14/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

protocol TrendingMovieCell {
    func display(title: String)
    func display(image: UIImage?)
    func startActivity()
    func stopActivity()
}

class MovieCollectionViewCell: UICollectionViewCell {
    static var reuseIdentifier = "MovieTableCell"
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
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
        addSubview(image)
        addSubview(title)
    }
    
    private func configure() {
        setupSubviews()
    
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            title.leadingAnchor.constraint(equalTo: image.leadingAnchor, constant: 10),
            title.trailingAnchor.constraint(equalTo: image.trailingAnchor, constant: -10),
            title.bottomAnchor.constraint(equalTo: image.bottomAnchor, constant: -50),
        ])
    }
}

extension MovieCollectionViewCell: TrendingMovieCell {
    func display(title: String) {
        self.title.text = title
    }
    
    func display(image: UIImage?) {
        self.image.image = image
    }
    
    func startActivity() {
        image.addSubview(activityIndicator)
        activityIndicator.hidesWhenStopped = true
        
        DispatchQueue.main.async {
            self.activityIndicator.center = CGPoint(x: self.image.bounds.width / 2, y: self.image.bounds.height / 2)
            self.activityIndicator.startAnimating()
        }
    }
    
    func stopActivity() {
        activityIndicator.stopAnimating()
    }
}
