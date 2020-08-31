//
//  TopSummaryView.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 28/10/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import Foundation
import UIKit

class TopSummaryView: NibLoadingView {
    
    // MARK: - Outlets
    @IBOutlet weak var greenCircle: UIView!
    @IBOutlet weak var redCircle: UIView!
    
    // MARK: - Setup View
    private func setupView() {
        view.layer.cornerRadius = 10
        view.addShadow(offset: CGSize(width: 3, height: 3), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2), radius: 3, opacity: 0.6)
        greenCircle.layer.cornerRadius = 0.5 * greenCircle.bounds.size.width
        redCircle.layer.cornerRadius = 0.5 * redCircle.bounds.size.width
    }
    
    //MARK: - LifeCycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
}
