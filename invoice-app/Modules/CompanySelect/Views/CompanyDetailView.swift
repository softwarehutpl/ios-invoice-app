//
//  CompanyDetailView.swift
//  invoice-app
//
//  Created by Bartłomiej Gaweł on 12/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class CompanyDetailView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var companyPhone: UILabel!
    @IBOutlet weak var companyEmail: UILabel!
    @IBOutlet weak var companyAddress: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var domainButton: UIButton!
    @IBAction func linkClicked(_ sender: Any) {
        openWebPage(URLString: domainButton.currentTitle!)
    }
    
    func openWebPage(URLString: String) {
        if let url = URL(string: URLString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    private func initView() {
        Bundle.main.loadNibNamed("CompanyDetailView", owner: self, options: nil)
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    }
}
