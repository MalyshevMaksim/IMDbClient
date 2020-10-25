//
//  MovieDetailViewProtocol.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 10/6/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

protocol MovieDetailViewProtocol {
    func display(image: UIImage?)
    func display(title: String)
    func display(imDbRating: String)
    func display(length: String)
    func display(releaseDate: String)
    func display(contentRating: String)
    func display(plot: String)
}
