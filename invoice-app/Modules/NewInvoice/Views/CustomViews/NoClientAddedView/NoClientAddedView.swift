//
//  NoClientAddedView.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 25/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class NoClientAddedView: UIView {
    
    var didTapAddClient: (() -> Void)?
    
    // MARK: - Outlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var clientsImage: UIImageView!
    @IBOutlet weak var noClientAddedLabel: UILabel!
    @IBOutlet weak var addClientLabel: UILabel!
    
    // MARK: - Actions
    
    // MARK: - Setup Views
    func setupOutlets() {
        clientsImage.tintColor = #colorLiteral(red: 0.1136931852, green: 0.4413411915, blue: 0.3557595909, alpha: 1)
        noClientAddedLabel.textColor = #colorLiteral(red: 0.1136931852, green: 0.4413411915, blue: 0.3557595909, alpha: 1)
        addClientLabel.textColor = #colorLiteral(red: 0.1136931852, green: 0.4413411915, blue: 0.3557595909, alpha: 1)
    }
    
    func addShadowToViews(views: [UIView]) {
        views.forEach { (view) in
            view.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 2.0, opacity: 0.35)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        setupOutlets()
    }
    
    private func commonInit() {
        let bundle = Bundle.init(for: type(of: self))
        let nib = UINib(nibName: "NoClientAddedView", bundle: bundle)
        contentView = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
    }
}
