//
//  CollectionView + EmptyStateMessage.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 16/09/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//
import UIKit

extension UICollectionView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.textColor = #colorLiteral(red: 0.02910782583, green: 0.4101666808, blue: 0.3079773188, alpha: 1)
        messageLabel.font = UIFont(name: "Empty List", size: 17)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel
    }
    
    func restore() {
        self.backgroundView = nil
    }
}
