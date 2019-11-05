//
//  ProfileViewController.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 30/10/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    //MARK: - Private
    private let viewModel: ProfileViewModelType
    
    init(with viewModel: ProfileViewModelType) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Profile"
    }
}
