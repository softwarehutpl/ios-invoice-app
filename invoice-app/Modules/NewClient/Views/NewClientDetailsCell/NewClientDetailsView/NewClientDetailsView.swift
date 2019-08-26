//
//  NewClientDetailsView.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 23/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//
import UIKit

class NewClientDetailsView: UIView {
    
    //MARK: - Outlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var clientName: UITextField!
    @IBOutlet weak var clientEmail: UITextField!
    @IBOutlet weak var clientPhone: UITextField!
    
    //MARK: Loading Data
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        let bundle = Bundle.init(for: type(of: self))
        let nib = UINib(nibName: "NewClientDetailsView", bundle: bundle)
        contentView = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
    }
}
