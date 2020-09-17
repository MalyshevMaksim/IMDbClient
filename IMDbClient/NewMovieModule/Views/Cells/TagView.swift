//
//  TagView.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/17/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

class TagView: UIView {
    lazy var text: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.addSubview(text)
        backgroundColor = .init(white: 1, alpha: 0.5)
        layer.cornerRadius = 5
        
        NSLayoutConstraint.activate([
            text.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            text.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.layoutMarginsGuide.trailingAnchor.constraint(equalTo: text.trailingAnchor),
            self.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
}
