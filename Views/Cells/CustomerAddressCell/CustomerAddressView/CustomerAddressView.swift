//
//  CustomerAddressView.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 14/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class CustomerAddressView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var address: UITextField!
    // MARK: OUTLETS
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func prepareView(client: ClientModel) {
        address.text = client.address
    }
    
    private func commonInit() {
        let bundle = Bundle.init(for: type(of: self))
        let nib = UINib(nibName: "CustomerAddressView", bundle: bundle)
        contentView = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
    }
}
