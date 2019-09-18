//
//  ItemsTableViewCell.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 18/09/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class ItemsTableViewCell: UITableViewCell {
    
    static let identyfier = "ItemsTableViewCell"
    
    var callback: (() -> Void)?
    
    //MARK: - Outlets
    @IBOutlet weak var customView: AddItemView!
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        customView.callback = {
            self.callback?()
        }
    }
}
