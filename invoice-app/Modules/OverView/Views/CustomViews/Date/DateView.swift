//
//  DateView.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 28/10/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import Foundation
import UIKit


class DateView: NibLoadingView {
    
    //MARK: - Outlets
    
    //MARK: - Setup View
    private func setupView() {
        view.layer.cornerRadius = 10
        view.addShadow(offset: CGSize(width: 3, height: 3), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2), radius: 3, opacity: 0.2)
    }
    
    //MARK: - Lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
}
