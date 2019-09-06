//
//  ClientCollectionViewCell.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 22/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class ClientCollectionViewCell: UICollectionViewCell {
    var cellIndex: Int?
    var callback: (() -> Void)?
    
    static let identyfier = "ClientCollectionViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var customView: ClientCellView!
    
    // MARK: Setup View
    func prepareView(client: ClientModel) {
        customView.prepareView(client: client)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.customView.callback = {
            self.callback?()
        }
    }
}
