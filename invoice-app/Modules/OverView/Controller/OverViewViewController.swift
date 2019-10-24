//
//  OverViewViewController.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 23/10/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class OverViewViewController: BaseViewController {

    //MARK: - Private
    private let viewModel: OverViewViewModelType
    
    //MARK: - Init
    init(viewModel: OverViewViewModelType) {
        self.viewModel = viewModel
        super.init()
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Overview"

        // Do any additional setup after loading the view.
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
