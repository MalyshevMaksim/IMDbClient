//
//  SearchMovieCell.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 10/6/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

class SearchMovieCell: UITableViewCell {
    static var reuseIdentifier = "MovieTableCell"
    var activityView: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        contentView.addSubview(title)
        contentView.addSubview(subtitle)
    }
    
    private func setupCell() {
        setupSubviews()
        
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            subtitle.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            subtitle.trailingAnchor.constraint(equalTo: title.trailingAnchor),
            
            contentView.layoutMarginsGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: subtitle.lastBaselineAnchor, multiplier: 0)
        ])
    }
}

extension SearchMovieCell: MovieCellProtocol {
    func display(image: UIImage?) {
        
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
        
    }
    
    func stopActivity() {
        
    }
}
