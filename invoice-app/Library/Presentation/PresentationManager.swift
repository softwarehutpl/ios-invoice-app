//
//  PresentationManager.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 24/09/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

enum PresentationDirection {
    case left
    case top
    case right
    case bottom
}

class PresentationManager: NSObject, PresentationManagerType {
    
    var direction = PresentationDirection.bottom
    
}

//MARK:- UIViewControllerTransitioningDelegate

extension PresentationManager: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        return PresentationController(presentedViewController: presented, presenting: presenting, direction: direction)
        
    }
    
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return PresentationAnimator(direction: direction, isPresentation: true)
        
    }
    
    
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return PresentationAnimator(direction: direction, isPresentation: false)
        
    }
    
}

