//
//  ChartsCell.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 30/10/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class ChartsCell: UITableViewCell {
    
    static var identyfier: String {
        return String(describing: self)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.init(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        // Initialization code
    }
}
