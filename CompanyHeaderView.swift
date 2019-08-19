//
//  CompanyHeaderView.swift
//  invoice-app
//
//  Created by Bartłomiej Gaweł on 12/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class CompanyHeaderView: UIView {
    
    var callback: (() -> Void)?
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var companyDescription: UILabel!
    
    @IBAction func expandCollapseButton(_ sender: UIButton) {
        callback?()
    }
    
    @IBOutlet weak var button: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    private func initView() {
        Bundle.main.loadNibNamed("CompanyHeaderView", owner: self, options: nil)
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    }
}
