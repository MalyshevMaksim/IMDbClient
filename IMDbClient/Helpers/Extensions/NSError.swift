//
//  NSError+MakeError.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 10/17/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation

extension NSError {
    static func makeError(withMessage message: String) -> NSError {
        return NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: message])
    }
}
