//
//  HeaderView.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/16/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

class HeaderView: UICollectionReusableView {
    static var reuseIdentifier = "HeaderView"
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "In Theaters"
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
       super.init(frame: frame)
       configure()
     }

     required init?(coder: NSCoder) {
       fatalError()
     }
    
    private func configure() {
        addSubview(label)
        
        let inset = CGFloat(10)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            label.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset)
        ])
    }
}
