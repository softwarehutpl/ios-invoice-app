//
//  InvoiceTableViewCell.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 29/10/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class InvoiceTableViewCell: UITableViewCell {

    static var identyfier: String {
        return String(describing: self)
    }
    
    //MARK: - Outlets
    @IBOutlet weak var customView: InvoiceCellView!
    
    //MARK: - SetupView
    private func setupView() {
        customView.contentView.layer.cornerRadius = 10
        customView.contentView.backgroundColor = UIColor.init(red: 146/255, green: 152/255, blue: 163/255, alpha: 0.1)
    }
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
}
