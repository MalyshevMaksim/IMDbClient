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
    var rating: Double? = 0 {
        didSet {
            configureStack(rating: rating)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureStack(rating: Double?) {
        guard let rating = rating else {
            return
        }
        
        let starCount = lround(Double(rating / 2))
            
        for _ in 0..<starCount {
            let image = UIImageView(image: UIImage(systemName: "star.fill"))
            image.tintColor = .systemOrange
            starStack.addArrangedSubview(image)
        }
        
        for _ in 0..<5 - starCount {
            let image = UIImageView(image: UIImage(systemName: "star"))
            image.tintColor = .systemOrange
            starStack.addArrangedSubview(image)
        }
    }

    lazy var starStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
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
