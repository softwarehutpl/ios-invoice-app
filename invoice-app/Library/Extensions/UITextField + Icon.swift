//
//  UITextField + Icon.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 26/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//
import UIKit

extension UITextField  {
    
    
    func setIcon(_ image: UIImage, iconColor: UIColor) {
        let iconView = UIImageView(frame:
            CGRect(x: 10, y: 5, width: 15, height: 15))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 20, y: 0, width: 25, height: 25))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
        iconView.tintColor = iconColor
        iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
    }
}
