//
//  UICollectionView.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/22/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import UIKit

extension UICollectionView {
    func showActivityIndicator() {
        let activityView = UIActivityIndicatorView(style: .large)
        self.backgroundView = activityView
        activityView.startAnimating()
    }

    func hideActivityIndicator() {
        self.backgroundView = nil
    }
}
