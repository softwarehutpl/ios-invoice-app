//
//  NewClientAddressView.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 23/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class NewClientAddressView: UIView {
    
    //MARK: - Outlets
    @IBOutlet var contentView: UIView!
    
    //MARK: Loading Data
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        let bundle = Bundle.init(for: type(of: self))
        let nib = UINib(nibName: "NewClientAddressView", bundle: bundle)
        contentView = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
    }
}
