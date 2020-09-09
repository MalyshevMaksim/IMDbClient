//
//  RatingStackView.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/8/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

class RatingStackView: UIView {
    private var rating: Float
    
    init(with rating: Float) {
        self.rating = rating
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var starStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        var starCount = self.rating / 2
        var counter = 0
            
        for star in 0..<5 {
            let image = UIImageView(image: UIImage(systemName: "star.fill"))
            image.tintColor = .systemOrange
            stackView.addArrangedSubview(image)
        }
        return stackView
    }()
    
    private func setupView() {
        addSubview(starStack)
        
        NSLayoutConstraint.activate([
            starStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            starStack.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
