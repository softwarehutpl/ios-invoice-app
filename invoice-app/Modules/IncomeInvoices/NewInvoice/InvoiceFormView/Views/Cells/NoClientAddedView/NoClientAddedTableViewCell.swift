//
//  NoClientAddedTableViewCell.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 25/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class NoClientAddedTableViewCell: UITableViewCell {
    static var identyfier: String {
        return String(describing: self)
    }
    // MARK: - Outlets
    @IBOutlet weak var customView: NoClientAddedView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
