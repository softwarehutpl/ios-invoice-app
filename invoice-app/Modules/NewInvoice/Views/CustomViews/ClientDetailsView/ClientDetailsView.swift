//
//  ClientDetails.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 21/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import Foundation
import UIKit

class ClientDetailsView: UIView {
    
    var callback: (() -> Void)?
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var rightEditButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    // Mark: - Setup View
    private func setupOutlets() {
        rightEditButton.tintColor = #colorLiteral(red: 0.1136931852, green: 0.4413411915, blue: 0.3557595909, alpha: 1)
    }
    
    // Mark: - Actions
    @IBAction func rightEditButtonTap(_ sender: UIButton) {
        callback?()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        setupOutlets()
    }
    
    private func commonInit() {
        let bundle = Bundle.init(for: type(of: self))
        let nib = UINib(nibName: "ClientDetailsView", bundle: bundle)
        contentView = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
    }
}
