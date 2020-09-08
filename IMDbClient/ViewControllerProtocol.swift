//
//  ViewControllerProtocol.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/4/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation


// Protocol defining actions upon successful download of data from the network or from a failure

protocol ViewControllerProtocol {
    func success()
    func failure(error: Error)
}