//
//  CellError.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 14/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class CellError {
    func showError(cellTitle: Any, cellID: String) -> String {
        return ("Expected \(cellTitle) type for reuseIdentifier \(cellID). Check the configuration")
    }
}
let cellError = CellError()
