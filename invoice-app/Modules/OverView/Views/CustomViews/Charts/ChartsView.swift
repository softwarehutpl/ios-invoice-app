//
//  ChartsView.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 28/10/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class ChartsView: NibLoadingView {
    
    //MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    
    //MARK: - Setup View
    private func setupView() {
        view.addShadow(offset: CGSize(width: 3, height: 3), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2), radius: 3, opacity: 0.6)
        view.layer.cornerRadius = 10
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
    }
    
    //MARK: - Lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    setupView()
     
    }
}
