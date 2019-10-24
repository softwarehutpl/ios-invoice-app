//
//  PresentationManager.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 24/09/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import Foundation
import Swinject

class PresentationManagerAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(PresentationManagerType.self) { _ in
            return PresentationManager()
        }
    }
}
