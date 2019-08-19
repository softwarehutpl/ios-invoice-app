//
//  CustomerItemsCell.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 15/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class CustomerItemsCell: UITableViewCell {

    static let identyfier = "CustomerItemsCell"
    
    @IBOutlet weak var customView: CustomerItemsView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func prepareView(item: ItemDescription) {
        customView.prepareView(item: item)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}