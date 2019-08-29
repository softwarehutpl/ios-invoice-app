//
//  ClientCollectionFlowLayout.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 21/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import Foundation
import UIKit

class ClientCollectionFlowLayout: UICollectionViewFlowLayout {
    
    let screenWidth = UIScreen.main.bounds.size.width - 20
    let screenHeight = UIScreen.main.bounds.size.height
    
    override func prepare() {
        super.prepare()
        minimumLineSpacing = 1
        itemSize = CGSize(width: screenWidth, height: screenHeight / 10)
    }
}
