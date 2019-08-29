//
//  NewClientDetailsViewCell.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 23/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class NewClientDetailsTableViewCell: UITableViewCell {
    
    var callback: ((NewClientDetailModel) -> Void)?
    
    static let identyfier = "NewClientDetailsViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var customView: NewClientDetailsView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customView.callback = { client in
            self.callback?(client)
        }
        // Initialization code
    }
}
