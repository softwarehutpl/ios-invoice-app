//
//  NewItemViewController.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 19/09/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class NewItemViewController: BaseViewController {
    
    //MARK: - Private
    private let viewModel: NewItemViewModelType
    
    //MARK: - Inits
    init(with viewModel: NewItemViewModelType) {
        self.viewModel = viewModel
        super.init()
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
