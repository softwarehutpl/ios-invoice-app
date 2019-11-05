//
//  NewClientDetailsViewCell.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 23/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class NewClientDetailsTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    var callback: ((ClientDetailsModel) -> Void)?
    static var identyfier: String {
        return String(describing: self)
    }
    @IBOutlet weak var customView: NewClientDetailsView!
    
    //MARK: - Setup View
    func prepareCell(clientDetails: ClientDetailsModel) {
        customView.prepareView(clientDetails: clientDetails)
    }
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        customView.callback = { client in
            self.callback?(client)
        }
    }
}
