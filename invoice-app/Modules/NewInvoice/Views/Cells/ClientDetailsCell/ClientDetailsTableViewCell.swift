//
//  ClientDetailsTableViewCell.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 24/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class ClientDetailsTableViewCell: UITableViewCell {
    
    var callback: (() -> Void)?
    static let identyfier = "ClientDetailsTableViewCell"
    
    //MARK: - Outlets
    @IBOutlet weak var customView: ClientDetailsView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customView.callback = {
            self.callback?()
        }
        // Initialization code
    }

}
