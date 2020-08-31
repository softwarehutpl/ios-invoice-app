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
    static var identyfier: String {
        return String(describing: self)
    }
    
    //MARK: - Outlets
    @IBOutlet weak var customView: ClientDetailsView!
    
    //MARK: - View Setup
    func prepareCell(client: ClientModel) {
        customView.prepareView(client: client)
    }
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        customView.callback = {
            self.callback?()
        }
    }

}
