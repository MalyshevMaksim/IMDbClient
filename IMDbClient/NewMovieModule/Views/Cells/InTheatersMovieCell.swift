//
//  NewMovieCollectionCell.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/14/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

protocol NewMovieCell {
    func display(title: String)
    func display(runtimeStr: String)
    func display(image: UIImage?)
    func startActivity()
    func stopActivity()
}

class InTheatersMovieCell: UICollectionViewCell {
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
    
    lazy var timeTag: TagView = {
        let tagView = TagView()
        tagView.translatesAutoresizingMaskIntoConstraints = false
        return tagView
    }()
    
    lazy var genresStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let drama = TagView()
        drama.text.text = "Drama"
        let th = TagView()
        th.text.text = "Thriller"
        stackView.addArrangedSubview(drama)
        stackView.addArrangedSubview(th)
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
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
        addSubview(timeTag)
        addSubview(genresStack)
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
        
            timeTag.trailingAnchor.constraint(equalTo: image.trailingAnchor, constant: -20),
            timeTag.topAnchor.constraint(equalTo: image.topAnchor, constant: 20),
            
            genresStack.leadingAnchor.constraint(equalTo: image.leadingAnchor, constant: 10),
            genresStack.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10)
        ])
    }
}

extension InTheatersMovieCell: NewMovieCell {
    func display(title: String) {
        self.title.text = title
    }
    
    func display(runtimeStr: String) {
        self.timeTag.text.text = runtimeStr
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
