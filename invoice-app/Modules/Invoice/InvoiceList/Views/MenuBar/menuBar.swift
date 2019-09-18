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
        topBarSegmentControl.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        topBarSegmentControl.layer.cornerRadius = 0
        topBarSegmentControl.layer.borderWidth = 1.5
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTopBarSegmentControl()
    }
}
