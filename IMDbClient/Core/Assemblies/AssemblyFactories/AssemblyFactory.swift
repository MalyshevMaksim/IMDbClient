//
//  AssemblyFactory.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/18/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import UIKit

// A factory that is responsible for creating resources for the presenter to load.
// In case of adding new resources to the system, it is enough to expand this interface.
// Thus, we close the presenter for change, but open it for extension.
// In addition, this will allow us to avoid duplicating the code of the Assembly builders

protocol AssemblyFactory {
    func makeRequests() -> [APIRequest]
    func makeViewController() -> ViewControllerProtocol
    func makeNetworkService() -> NetworkService
}
