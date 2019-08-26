//
//  ClientCollectionViewCell.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 22/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class ClientCollectionViewCell: UICollectionViewCell {

    static let identyfier = "ClientCollectionViewCell"
    @IBOutlet weak var customView: ClientCellView!
    
    func prepareView(client: ClientModel) {
        customView.prepareView(client: client)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
