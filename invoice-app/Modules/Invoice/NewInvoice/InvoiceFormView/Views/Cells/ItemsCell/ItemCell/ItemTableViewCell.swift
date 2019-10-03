//
//  ItemTableViewCell.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 25/09/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    var callback: ((ItemModel) -> Void)?
    static let identyfier = "ItemTableViewCell"
    @IBOutlet weak var customView: CellItemView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customView.passItem = { [weak self] item in
            guard let `self` = self else { return }
            self.callback?(item)
        }
       self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
       self.layer.shadowOffset = CGSize(width: 0, height: 3    )
       self.layer.shadowOpacity = 0.2
       self.layer.shadowRadius = 2.0
    }
    
}
