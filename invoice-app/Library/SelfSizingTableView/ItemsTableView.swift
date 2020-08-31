//
//  ItemsTableView.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 17/09/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class SelfSizingTableView: UITableView {
    
    var maxHeight: CGFloat = UIScreen.main.bounds.size.height
    
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
    }
    
    override var intrinsicContentSize: CGSize {
        let height = min(contentSize.height, maxHeight)
        return CGSize(width: contentSize.width, height: height)
    }
}
