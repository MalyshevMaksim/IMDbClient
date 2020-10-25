//
//  MovieCell.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/18/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import UIKit

protocol MovieCellProtocol {
    func display(title: String)
    func display(subtitle: String)
    func display(imDbRating: String)
    func display(imDbRatingCount: String)
    func display(image: UIImage?)
    func startActivity()
    func stopActivity()
}
