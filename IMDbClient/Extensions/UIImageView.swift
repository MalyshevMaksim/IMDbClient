//
//  UIImageView.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/2/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func downloadImage(from url: String) {
        guard let url = URL(string: url) else { fatalError("Error") }
        
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.startAnimating()
        activityIndicator.center = self.center
        activityIndicator.hidesWhenStopped = true
        addSubview(activityIndicator)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else { fatalError("Error") }
            
            DispatchQueue.main.async {
                UIView.transition(with: self, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    self.image = image
                    activityIndicator.stopAnimating()
                })
            }
        }.resume()
    }
}
