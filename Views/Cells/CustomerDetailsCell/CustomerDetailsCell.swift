//
//  CustomerDetailsCell.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 13/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class CustomerDetailsCell: UITableViewCell {
    
    static let identyfier = "CustomerDetailsCell"
    
    @IBOutlet weak var customView: CustomerDetailView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func prepareView(client: ClientModel) {
        customView.prepareView(client: client)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
