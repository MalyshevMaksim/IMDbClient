//
//  ActivityIndicatorView.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/3/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

class ActivityIndicatorVew: UIView {
    var backgroundView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func start() {
        activityIndicator.startAnimating()
        backgroundView.alpha = 1
    }
    
    func stop() {
        activityIndicator.stopAnimating()
        
        UIView.transition(with: backgroundView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.backgroundView.alpha = 0
        })
    }
    
    private func setupBackgroundView() {
        backgroundView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        backgroundView.clipsToBounds = true
        backgroundView.layer.cornerRadius = 10
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupIndicator() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .white
        activityIndicator.style = .large
        activityIndicator.center = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2);
    }
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Loading"
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private func setupSubviews() {
        addSubview(backgroundView)
        addSubview(activityIndicator)
        
        setupBackgroundView()
        setupIndicator()
        backgroundView.addSubview(activityIndicator)
        backgroundView.addSubview(label)
    }
    
    private func setupView() {
        setupSubviews()
        
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
}
