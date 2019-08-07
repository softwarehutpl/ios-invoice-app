//
//  UICollectionFlowLayout + "".swift
//  invoice-app
//
//  Created by Damian Szejnoch on 07/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import Foundation

import UIKit


extension UICollectionViewFlowLayout {
    private static func newInstance(minimalSpacing: CGFloat,backgroundColor: UIColor) -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.minimumLineSpacing = minimalSpacing
        flowLayout.collectionView?.backgroundColor = backgroundColor
        
        return flowLayout
    }
    
    static var standardSpacingWithBlueBackground: UICollectionViewFlowLayout {
        return newInstance(minimalSpacing: 5, backgroundColor: .blue)
    }
}
