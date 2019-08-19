//
//  CompanyCell.swift
//  invoice-app
//
//  Created by Bartłomiej Gaweł on 12/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class CompanyCell: UITableViewCell {
    
    @IBOutlet weak var headerView: CompanyHeaderView!
    @IBOutlet weak var detailView: CompanyDetailView!

    func prepareCell(company: CompanyModel) {
        headerView.companyName.text = company.name
        headerView.companyDescription.text = company.description
        detailView.domainButton.setTitle(company.domain, for: .normal)
        detailView.companyPhone.text = company.phone
        detailView.companyAddress.text = company.address
        detailView.companyEmail.text = company.email
        
        if company.isExpanded {
            detailView.isHidden = false
            headerView.button.setImage(UIImage(named: "hide_button.png"), for: .normal)
        } else {
            detailView.isHidden = true
            headerView.button.setImage(UIImage(named: "show_button.png"), for: .normal)
        }
    }
    
    var callback: (() -> Void)?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        headerView.callback = {
            self.callback?()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
