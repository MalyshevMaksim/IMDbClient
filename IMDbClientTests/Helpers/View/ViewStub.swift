//
//  File.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 10/23/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

class ViewStub: UIViewController, ViewControllerProtocol {
    var presenter: MoviePresenterProtocol!
    var isSuccessCalled = false
    
    func success() {
        isSuccessCalled = true
    }
    
    func failure(error: Error) {
        isSuccessCalled = false
    }
}
