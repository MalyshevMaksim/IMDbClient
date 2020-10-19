//
//  UITableView.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/10/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import UIKit

extension UITableView {
    func showActivityIndicator() {
        let activityView = UIActivityIndicatorView(style: .large)
        self.backgroundView = activityView
        activityView.startAnimating()
    }

    func hideActivityIndicator() {
        self.backgroundView = nil
    }
}
