//
//  File.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 10/23/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation

class RouterDummy: RouterProtocol {
    var isDetailShowing = false
    
    func initialNavigationController() {
        
    }
    
    func showDetail(movieId: String) {
        isDetailShowing = true
    }
}
