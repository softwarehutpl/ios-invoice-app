//
//  menuBar.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 10/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

protocol SegmentControllerProtocol {
    func passFilteringIndexType(index: Int)
}

class menuBar: NibLoadingView {
    
    static var selectedIndex: Int?
    var delegate: SegmentControllerProtocol?
    
    // MARK: - View objects
    @IBOutlet weak var topBarSegmentControl: UISegmentedControl!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var label: UILabel!
    
    @IBAction func onSegmentValueChanged(_ sender: UISegmentedControl) {
        menuBar.selectedIndex = sender.selectedSegmentIndex
        delegate?.passFilteringIndexType(index: sender.selectedSegmentIndex)
    }
    
    // MARK: - SegmentController setup
    func setupTopBarSegmentControl() {
        topBarSegmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:
                   UIColor.white], for: UIControl.State.normal)
        topBarSegmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:
            #colorLiteral(red: 0.1136931852, green: 0.4413411915, blue: 0.3557595909, alpha: 1)], for: UIControl.State.selected)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTopBarSegmentControl()
        layoutSubviews()
    }
}
