//
//  InvoiceCollectionFlowLayout.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 06/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class InvoiceCollectionFlowLayout: UICollectionViewFlowLayout {
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    override func prepare() {
        super.prepare()
        minimumLineSpacing = 1
        itemSize = CGSize(width: screenWidth, height: screenHeight / 8)
    }
}


