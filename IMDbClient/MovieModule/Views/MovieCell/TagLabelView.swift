//
//  RatingTagView.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/3/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

class TagLabelView: UIView {
    lazy var rating: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 3
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(rating)
        
        NSLayoutConstraint.activate([
            rating.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            rating.centerYAnchor.constraint(equalTo: centerYAnchor),
            layoutMarginsGuide.trailingAnchor.constraint(equalTo: rating.trailingAnchor, constant: 5),
            layoutMarginsGuide.bottomAnchor.constraint(equalTo: rating.bottomAnchor)
        ])
    }
}
